#include <metal_stdlib>
using namespace metal;

// ============================================================================
// MARK: - Utility Functions
// ============================================================================

// Smooth minimum for blob merging
float smin(float a, float b, float k) {
    float h = clamp(0.5 + 0.5 * (b - a) / k, 0.0, 1.0);
    return mix(b, a, h) - k * h * (1.0 - h);
}

// Smooth maximum
float smax(float a, float b, float k) {
    return -smin(-a, -b, k);
}

// ============================================================================
// MARK: - Noise Functions
// ============================================================================

// Hash function for noise
float hash(float3 p) {
    p = fract(p * 0.3183099 + 0.1);
    p *= 17.0;
    return fract(p.x * p.y * p.z * (p.x + p.y + p.z));
}

// 3D Value noise
float noise(float3 p) {
    float3 i = floor(p);
    float3 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);
    
    return mix(
        mix(
            mix(hash(i + float3(0, 0, 0)), hash(i + float3(1, 0, 0)), f.x),
            mix(hash(i + float3(0, 1, 0)), hash(i + float3(1, 1, 0)), f.x),
            f.y
        ),
        mix(
            mix(hash(i + float3(0, 0, 1)), hash(i + float3(1, 0, 1)), f.x),
            mix(hash(i + float3(0, 1, 1)), hash(i + float3(1, 1, 1)), f.x),
            f.y
        ),
        f.z
    );
}

// Fractal Brownian Motion for organic displacement
float fbm(float3 p) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;
    
    for (int i = 0; i < 4; i++) {
        value += amplitude * noise(p * frequency);
        amplitude *= 0.5;
        frequency *= 2.0;
    }
    
    return value;
}

// ============================================================================
// MARK: - Signed Distance Functions
// ============================================================================

// Sphere SDF
float sdSphere(float3 p, float r) {
    return length(p) - r;
}

// Torus SDF
float sdTorus(float3 p, float2 t) {
    float2 q = float2(length(p.xz) - t.x, p.y);
    return length(q) - t.y;
}

// Main orb SDF - morphs between torus and sphere
float orbSDF(float3 p, float morphAmount, float time, float audioLevel) {
    // Rotate for more interesting view
    float angle = time * 0.2;
    float cosA = cos(angle);
    float sinA = sin(angle);
    float3 rotP = float3(
        p.x * cosA - p.z * sinA,
        p.y,
        p.x * sinA + p.z * cosA
    );
    
    // Tilt for better torus visibility
    float tiltAngle = 0.4 + sin(time * 0.3) * 0.1;
    float cosT = cos(tiltAngle);
    float sinT = sin(tiltAngle);
    rotP = float3(
        rotP.x,
        rotP.y * cosT - rotP.z * sinT,
        rotP.y * sinT + rotP.z * cosT
    );
    
    // Apply noise displacement for organic wobble
    float noiseIntensity = 0.02 + audioLevel * 0.06;
    float3 noiseOffset = float3(
        fbm(rotP * 3.0 + float3(time * 0.5, 0, 0)),
        fbm(rotP * 3.0 + float3(0, time * 0.5, 0)),
        fbm(rotP * 3.0 + float3(0, 0, time * 0.5))
    );
    float3 displacedP = rotP + noiseOffset * noiseIntensity;
    
    // Torus parameters - ring with hole
    float2 torusSize = float2(0.35, 0.12);
    
    // Sphere parameters - compressed
    float sphereRadius = 0.38;
    
    // Calculate both distances
    float torusDist = sdTorus(displacedP, torusSize);
    float sphereDist = sdSphere(displacedP, sphereRadius);
    
    // Smooth blend between torus and sphere based on morphAmount
    // morphAmount: 0 = torus (open), 1 = sphere (closed)
    float baseDist = mix(torusDist, sphereDist, morphAmount);
    
    // Add subtle surface noise
    float surfaceNoise = (fbm(rotP * 8.0 + time * 0.3) - 0.5) * 0.01 * (1.0 + audioLevel);
    
    return baseDist + surfaceNoise;
}

// ============================================================================
// MARK: - Raymarching
// ============================================================================

struct RaymarchResult {
    float distance;
    float3 position;
    int steps;
    bool hit;
};

RaymarchResult raymarch(float3 ro, float3 rd, float morphAmount, float time, float audioLevel) {
    RaymarchResult result;
    result.distance = 0.0;
    result.hit = false;
    result.steps = 0;
    
    float t = 0.0;
    
    for (int i = 0; i < 100; i++) {
        result.steps = i;
        float3 p = ro + rd * t;
        float d = orbSDF(p, morphAmount, time, audioLevel);
        
        if (d < 0.001) {
            result.hit = true;
            result.distance = t;
            result.position = p;
            break;
        }
        
        if (t > 10.0) break;
        
        t += d * 0.8; // Slightly conservative step
    }
    
    result.distance = t;
    result.position = ro + rd * t;
    return result;
}

// Calculate normal via gradient
float3 calcNormal(float3 p, float morphAmount, float time, float audioLevel) {
    float2 e = float2(0.001, 0.0);
    return normalize(float3(
        orbSDF(p + e.xyy, morphAmount, time, audioLevel) - orbSDF(p - e.xyy, morphAmount, time, audioLevel),
        orbSDF(p + e.yxy, morphAmount, time, audioLevel) - orbSDF(p - e.yxy, morphAmount, time, audioLevel),
        orbSDF(p + e.yyx, morphAmount, time, audioLevel) - orbSDF(p - e.yyx, morphAmount, time, audioLevel)
    ));
}

// ============================================================================
// MARK: - Lighting & Materials
// ============================================================================

// Fresnel - dark edges
float fresnel(float3 viewDir, float3 normal, float power) {
    return pow(1.0 - max(dot(viewDir, normal), 0.0), power);
}

// Refract with chromatic aberration
float3 refractChromatic(float3 rayDir, float3 normal, float baseIOR) {
    // Different IOR for each channel creates prismatic effect
    float iorR = baseIOR - 0.04;
    float iorG = baseIOR;
    float iorB = baseIOR + 0.04;
    
    float3 refractedR = refract(rayDir, normal, 1.0 / iorR);
    float3 refractedG = refract(rayDir, normal, 1.0 / iorG);
    float3 refractedB = refract(rayDir, normal, 1.0 / iorB);
    
    // Sample from environment gradient based on refracted direction
    // Cool blue tones with warm amber accents
    float3 envColorR = mix(
        float3(0.83, 0.87, 0.93), // Ice blue
        float3(0.83, 0.64, 0.45), // Amber
        clamp(refractedR.y * 0.5 + 0.5 + refractedR.x * 0.3, 0.0, 1.0)
    );
    float3 envColorG = mix(
        float3(0.66, 0.77, 0.85), // Steel blue  
        float3(0.95, 0.90, 0.82), // Warm white
        clamp(refractedG.y * 0.5 + 0.5 + refractedG.x * 0.3, 0.0, 1.0)
    );
    float3 envColorB = mix(
        float3(0.55, 0.70, 0.80), // Cool steel
        float3(0.55, 0.37, 0.24), // Brown
        clamp(refractedB.y * 0.5 + 0.5 + refractedB.x * 0.3, 0.0, 1.0)
    );
    
    return float3(envColorR.r, envColorG.g, envColorB.b);
}

// ============================================================================
// MARK: - Main Kernel
// ============================================================================

kernel void siriOrbShader(
    texture2d<float, access::write> output [[texture(0)]],
    constant float &time [[buffer(0)]],
    constant float &audioLevel [[buffer(1)]],
    constant float2 &resolution [[buffer(2)]],
    uint2 gid [[thread_position_in_grid]]
) {
    // Bounds check
    if (gid.x >= uint(resolution.x) || gid.y >= uint(resolution.y)) {
        return;
    }
    
    // Normalized coordinates (-1 to 1), y-flipped
    float2 uv = (float2(gid) - resolution * 0.5) / min(resolution.x, resolution.y);
    uv.y = -uv.y;
    
    // Camera setup
    float3 ro = float3(0.0, 0.0, 1.8); // Camera position
    float3 rd = normalize(float3(uv, -1.0)); // Ray direction
    
    // Smooth audio level with low-pass filter simulation
    float smoothAudio = audioLevel;
    
    // Morph amount: low audio = torus (0), high audio = sphere (1)
    float morphAmount = smoothstep(0.0, 1.0, smoothAudio);
    
    // Raymarch the scene
    RaymarchResult hit = raymarch(ro, rd, morphAmount, time, smoothAudio);
    
    // Background - clean white with subtle gradient
    float3 bgColor = float3(0.98, 0.98, 0.99);
    bgColor = mix(bgColor, float3(0.95, 0.96, 0.98), length(uv) * 0.3);
    
    float3 color = bgColor;
    
    if (hit.hit) {
        float3 p = hit.position;
        float3 n = calcNormal(p, morphAmount, time, smoothAudio);
        float3 v = normalize(ro - p);
        
        // Fresnel - dark edges characteristic of glass
        float fresnelTerm = fresnel(v, n, 3.0);
        
        // Chromatic refraction
        float baseIOR = 1.45;
        float3 refractedColor = refractChromatic(-rd, n, baseIOR);
        
        // Reflection - environment gradient
        float3 reflDir = reflect(-rd, n);
        float3 reflColor = mix(
            float3(0.85, 0.90, 0.95),
            float3(0.95, 0.92, 0.88),
            clamp(reflDir.y * 0.5 + 0.5, 0.0, 1.0)
        );
        
        // Mix refraction and reflection based on fresnel
        float3 glassColor = mix(refractedColor, reflColor, fresnelTerm * 0.5);
        
        // Add dark fresnel edges
        float edgeDarkening = pow(fresnelTerm, 1.5) * 0.4;
        glassColor = mix(glassColor, float3(0.3, 0.35, 0.4), edgeDarkening);
        
        // Specular highlights - bright caustics
        float3 lightDir1 = normalize(float3(1.0, 1.0, 1.0));
        float3 lightDir2 = normalize(float3(-0.5, 0.8, 0.3));
        
        float3 h1 = normalize(lightDir1 + v);
        float3 h2 = normalize(lightDir2 + v);
        
        float spec1 = pow(max(dot(n, h1), 0.0), 80.0);
        float spec2 = pow(max(dot(n, h2), 0.0), 60.0);
        
        float3 specular = spec1 * float3(1.0, 1.0, 1.0) * 0.8 +
                          spec2 * float3(0.95, 0.97, 1.0) * 0.5;
        
        // Add inner glow based on audio
        float innerGlow = smoothstep(0.5, 0.0, length(p)) * smoothAudio * 0.3;
        float3 glowColor = float3(0.6, 0.75, 0.9) + float3(0.2, 0.1, 0.0) * sin(time + p.x * 5.0);
        glassColor += glowColor * innerGlow;
        
        // Combine
        color = glassColor + specular;
        
        // Subsurface scattering approximation for liquid look
        float sss = max(0.0, dot(-lightDir1, n)) * 0.15;
        color += float3(0.7, 0.85, 1.0) * sss * (1.0 + smoothAudio);
        
        // Soft shadow / ambient occlusion approximation
        float ao = 1.0 - float(hit.steps) / 100.0 * 0.3;
        color *= ao;
    }
    
    // Add subtle vignette
    float vignette = 1.0 - length(uv) * 0.2;
    color *= vignette;
    
    // Gamma correction
    color = pow(color, float3(1.0 / 2.2));
    
    // Clamp and output
    color = clamp(color, 0.0, 1.0);
    output.write(float4(color, 1.0), gid);
}
