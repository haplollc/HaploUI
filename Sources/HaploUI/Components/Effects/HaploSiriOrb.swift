import SwiftUI
import MetalKit
import AVFoundation
import Combine

// MARK: - Public SwiftUI View

/// A beautiful audio-reactive Siri-style orb that morphs between a torus and sphere
/// based on microphone input. Uses Metal shaders for raymarched glass effect with
/// chromatic aberration and organic liquid motion.
public struct HaploSiriOrb: View {
    @StateObject private var audioEngine = AudioReactiveEngine()
    
    /// The size of the orb view
    public var size: CGFloat
    
    /// Whether to actively listen to microphone input
    public var isListening: Bool
    
    /// Creates a new Siri Orb
    /// - Parameters:
    ///   - size: The size of the orb (default: 200)
    ///   - isListening: Whether to capture microphone audio (default: true)
    public init(size: CGFloat = 200, isListening: Bool = true) {
        self.size = size
        self.isListening = isListening
    }
    
    public var body: some View {
        MetalOrbView(
            audioLevel: audioEngine.smoothedAudioLevel,
            size: size
        )
        .frame(width: size, height: size)
        .onAppear {
            if isListening {
                audioEngine.start()
            }
        }
        .onDisappear {
            audioEngine.stop()
        }
        .onChange(of: isListening) { _, newValue in
            if newValue {
                audioEngine.start()
            } else {
                audioEngine.stop()
            }
        }
    }
}

// MARK: - Demo Mode Extension

extension HaploSiriOrb {
    /// Creates an orb in demo mode with simulated audio
    public static func demo(size: CGFloat = 200) -> some View {
        DemoSiriOrb(size: size)
    }
}

/// Demo version that simulates audio input
struct DemoSiriOrb: View {
    @StateObject private var demoEngine = DemoAudioEngine()
    var size: CGFloat
    
    var body: some View {
        MetalOrbView(
            audioLevel: demoEngine.audioLevel,
            size: size
        )
        .frame(width: size, height: size)
        .onAppear {
            demoEngine.start()
        }
        .onDisappear {
            demoEngine.stop()
        }
    }
}

// MARK: - Metal View Wrapper

#if os(iOS)
struct MetalOrbView: UIViewRepresentable {
    var audioLevel: Float
    var size: CGFloat
    
    func makeUIView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.delegate = context.coordinator
        mtkView.enableSetNeedsDisplay = false
        mtkView.isPaused = false
        mtkView.preferredFramesPerSecond = 60
        mtkView.framebufferOnly = false
        mtkView.clearColor = MTLClearColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1.0)
        mtkView.backgroundColor = .white
        mtkView.isOpaque = true
        
        context.coordinator.setup(device: mtkView.device!)
        
        return mtkView
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) {
        context.coordinator.audioLevel = audioLevel
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MTKViewDelegate {
        var device: MTLDevice?
        var commandQueue: MTLCommandQueue?
        var computePipeline: MTLComputePipelineState?
        var startTime: CFAbsoluteTime = CFAbsoluteTimeGetCurrent()
        var audioLevel: Float = 0.0
        
        func setup(device: MTLDevice) {
            self.device = device
            self.commandQueue = device.makeCommandQueue()
            
            // Load the shader from the package bundle
            guard let library = loadShaderLibrary(device: device) else {
                print("Failed to load Metal library")
                return
            }
            
            guard let function = library.makeFunction(name: "siriOrbShader") else {
                print("Failed to find siriOrbShader function")
                return
            }
            
            do {
                computePipeline = try device.makeComputePipelineState(function: function)
            } catch {
                print("Failed to create compute pipeline: \(error)")
            }
        }
        
        private func loadShaderLibrary(device: MTLDevice) -> MTLLibrary? {
            // Try loading from the bundle (for Swift Package)
            if let bundleURL = Bundle.module.url(forResource: "SiriOrb", withExtension: "metal"),
               let source = try? String(contentsOf: bundleURL, encoding: .utf8) {
                do {
                    return try device.makeLibrary(source: source, options: nil)
                } catch {
                    print("Failed to compile Metal source: \(error)")
                }
            }
            
            // Try loading from default library
            if let library = device.makeDefaultLibrary() {
                return library
            }
            
            // Fallback: compile from embedded source
            return try? device.makeLibrary(source: metalShaderSource, options: nil)
        }
        
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
        
        func draw(in view: MTKView) {
            guard let computePipeline = computePipeline,
                  let commandBuffer = commandQueue?.makeCommandBuffer(),
                  let drawable = view.currentDrawable else {
                return
            }
            
            let texture = drawable.texture
            
            guard let computeEncoder = commandBuffer.makeComputeCommandEncoder() else {
                return
            }
            
            computeEncoder.setComputePipelineState(computePipeline)
            computeEncoder.setTexture(texture, index: 0)
            
            // Time uniform
            var time = Float(CFAbsoluteTimeGetCurrent() - startTime)
            computeEncoder.setBytes(&time, length: MemoryLayout<Float>.size, index: 0)
            
            // Audio level uniform
            var level = audioLevel
            computeEncoder.setBytes(&level, length: MemoryLayout<Float>.size, index: 1)
            
            // Resolution uniform
            var resolution = SIMD2<Float>(Float(texture.width), Float(texture.height))
            computeEncoder.setBytes(&resolution, length: MemoryLayout<SIMD2<Float>>.size, index: 2)
            
            // Dispatch threads
            let threadGroupSize = MTLSize(width: 16, height: 16, depth: 1)
            let threadGroups = MTLSize(
                width: (texture.width + threadGroupSize.width - 1) / threadGroupSize.width,
                height: (texture.height + threadGroupSize.height - 1) / threadGroupSize.height,
                depth: 1
            )
            
            computeEncoder.dispatchThreadgroups(threadGroups, threadsPerThreadgroup: threadGroupSize)
            computeEncoder.endEncoding()
            
            commandBuffer.present(drawable)
            commandBuffer.commit()
        }
    }
}

#elseif os(macOS)
struct MetalOrbView: NSViewRepresentable {
    var audioLevel: Float
    var size: CGFloat
    
    func makeNSView(context: Context) -> MTKView {
        let mtkView = MTKView()
        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.delegate = context.coordinator
        mtkView.enableSetNeedsDisplay = false
        mtkView.isPaused = false
        mtkView.preferredFramesPerSecond = 60
        mtkView.framebufferOnly = false
        mtkView.clearColor = MTLClearColor(red: 0.98, green: 0.98, blue: 0.99, alpha: 1.0)
        mtkView.layer?.backgroundColor = NSColor.white.cgColor
        
        context.coordinator.setup(device: mtkView.device!)
        
        return mtkView
    }
    
    func updateNSView(_ nsView: MTKView, context: Context) {
        context.coordinator.audioLevel = audioLevel
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MTKViewDelegate {
        var device: MTLDevice?
        var commandQueue: MTLCommandQueue?
        var computePipeline: MTLComputePipelineState?
        var startTime: CFAbsoluteTime = CFAbsoluteTimeGetCurrent()
        var audioLevel: Float = 0.0
        
        func setup(device: MTLDevice) {
            self.device = device
            self.commandQueue = device.makeCommandQueue()
            
            guard let library = loadShaderLibrary(device: device) else {
                print("Failed to load Metal library")
                return
            }
            
            guard let function = library.makeFunction(name: "siriOrbShader") else {
                print("Failed to find siriOrbShader function")
                return
            }
            
            do {
                computePipeline = try device.makeComputePipelineState(function: function)
            } catch {
                print("Failed to create compute pipeline: \(error)")
            }
        }
        
        private func loadShaderLibrary(device: MTLDevice) -> MTLLibrary? {
            if let bundleURL = Bundle.module.url(forResource: "SiriOrb", withExtension: "metal"),
               let source = try? String(contentsOf: bundleURL, encoding: .utf8) {
                do {
                    return try device.makeLibrary(source: source, options: nil)
                } catch {
                    print("Failed to compile Metal source: \(error)")
                }
            }
            
            if let library = device.makeDefaultLibrary() {
                return library
            }
            
            return try? device.makeLibrary(source: metalShaderSource, options: nil)
        }
        
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {}
        
        func draw(in view: MTKView) {
            guard let computePipeline = computePipeline,
                  let commandBuffer = commandQueue?.makeCommandBuffer(),
                  let drawable = view.currentDrawable else {
                return
            }
            
            let texture = drawable.texture
            
            guard let computeEncoder = commandBuffer.makeComputeCommandEncoder() else {
                return
            }
            
            computeEncoder.setComputePipelineState(computePipeline)
            computeEncoder.setTexture(texture, index: 0)
            
            var time = Float(CFAbsoluteTimeGetCurrent() - startTime)
            computeEncoder.setBytes(&time, length: MemoryLayout<Float>.size, index: 0)
            
            var level = audioLevel
            computeEncoder.setBytes(&level, length: MemoryLayout<Float>.size, index: 1)
            
            var resolution = SIMD2<Float>(Float(texture.width), Float(texture.height))
            computeEncoder.setBytes(&resolution, length: MemoryLayout<SIMD2<Float>>.size, index: 2)
            
            let threadGroupSize = MTLSize(width: 16, height: 16, depth: 1)
            let threadGroups = MTLSize(
                width: (texture.width + threadGroupSize.width - 1) / threadGroupSize.width,
                height: (texture.height + threadGroupSize.height - 1) / threadGroupSize.height,
                depth: 1
            )
            
            computeEncoder.dispatchThreadgroups(threadGroups, threadsPerThreadgroup: threadGroupSize)
            computeEncoder.endEncoding()
            
            commandBuffer.present(drawable)
            commandBuffer.commit()
        }
    }
}
#endif

// MARK: - Audio Reactive Engine

/// Captures microphone input and calculates audio level
class AudioReactiveEngine: ObservableObject {
    @Published var audioLevel: Float = 0.0
    @Published var smoothedAudioLevel: Float = 0.0
    @Published var isListening: Bool = false
    
    private var audioEngine: AVAudioEngine?
    private var smoothingFactor: Float = 0.15
    private var lastUpdate: CFAbsoluteTime = 0
    
    func start() {
        guard !isListening else { return }
        
        #if os(iOS)
        Task { @MainActor in
            let granted = await requestPermission()
            if granted {
                self.setupAudioEngine()
            }
        }
        #else
        setupAudioEngine()
        #endif
    }
    
    func stop() {
        guard isListening else { return }
        
        audioEngine?.stop()
        audioEngine?.inputNode.removeTap(onBus: 0)
        audioEngine = nil
        
        isListening = false
        audioLevel = 0
        smoothedAudioLevel = 0
    }
    
    #if os(iOS)
    private func requestPermission() async -> Bool {
        return await withCheckedContinuation { continuation in
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                continuation.resume(returning: granted)
            }
        }
    }
    #endif
    
    private func setupAudioEngine() {
        audioEngine = AVAudioEngine()
        
        guard let audioEngine = audioEngine else { return }
        
        #if os(iOS)
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playAndRecord, mode: .measurement, options: [.defaultToSpeaker, .allowBluetooth])
            try audioSession.setActive(true)
        } catch {
            print("Failed to configure audio session: \(error)")
            return
        }
        #endif
        
        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buffer, _ in
            let level = self?.calculateRMS(buffer: buffer) ?? 0
            
            DispatchQueue.main.async {
                self?.audioLevel = level
                // Low-pass filter for smooth animation
                if let self = self {
                    self.smoothedAudioLevel = self.smoothedAudioLevel * (1 - self.smoothingFactor) + level * self.smoothingFactor
                }
            }
        }
        
        do {
            audioEngine.prepare()
            try audioEngine.start()
            isListening = true
        } catch {
            print("Failed to start audio engine: \(error)")
        }
    }
    
    private func calculateRMS(buffer: AVAudioPCMBuffer) -> Float {
        guard let channelData = buffer.floatChannelData else { return 0 }
        
        let channelDataValue = channelData.pointee
        let frameLength = Int(buffer.frameLength)
        
        var rms: Float = 0
        for i in stride(from: 0, to: frameLength, by: buffer.stride) {
            rms += channelDataValue[i] * channelDataValue[i]
        }
        rms = sqrt(rms / Float(frameLength))
        
        // Convert to dB and normalize to 0-1
        let avgPower = 20 * log10(max(rms, 0.0001))
        let minDb: Float = -60
        let maxDb: Float = -10
        let normalized = (avgPower - minDb) / (maxDb - minDb)
        
        return max(0, min(1, normalized))
    }
}

// MARK: - Demo Audio Engine

/// Simulates audio input for demo purposes
class DemoAudioEngine: ObservableObject {
    @Published var audioLevel: Float = 0.0
    
    private var displayLink: Timer?
    private var phase: Float = 0
    
    func start() {
        displayLink = Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { [weak self] _ in
            self?.updateLevel()
        }
    }
    
    func stop() {
        displayLink?.invalidate()
        displayLink = nil
        audioLevel = 0
    }
    
    private func updateLevel() {
        phase += 0.08
        
        // Simulate voice-like audio patterns
        let base = sin(phase) * 0.25
        let mid = sin(phase * 2.3) * 0.15
        let high = sin(phase * 5.7) * 0.1
        let noise = Float.random(in: -0.08...0.08)
        
        // Create speech-like bursts
        let burst = sin(phase * 0.25) > 0.3 ? Float(0.25) : Float(0)
        
        var level = Float(base + mid + high) + noise + burst
        level = (level + 0.5) * 0.7
        
        // Add silence gaps for realism
        if sin(phase * 0.12) < -0.6 {
            level *= 0.05
        }
        
        audioLevel = max(0, min(1, level))
    }
}

// MARK: - Embedded Shader Source (Fallback)

/// Embedded Metal shader source as fallback when bundle loading fails
private let metalShaderSource = """
#include <metal_stdlib>
using namespace metal;

float smin(float a, float b, float k) {
    float h = clamp(0.5 + 0.5 * (b - a) / k, 0.0, 1.0);
    return mix(b, a, h) - k * h * (1.0 - h);
}

float hash(float3 p) {
    p = fract(p * 0.3183099 + 0.1);
    p *= 17.0;
    return fract(p.x * p.y * p.z * (p.x + p.y + p.z));
}

float noise(float3 p) {
    float3 i = floor(p);
    float3 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);
    return mix(mix(mix(hash(i + float3(0,0,0)), hash(i + float3(1,0,0)), f.x),
                   mix(hash(i + float3(0,1,0)), hash(i + float3(1,1,0)), f.x), f.y),
               mix(mix(hash(i + float3(0,0,1)), hash(i + float3(1,0,1)), f.x),
                   mix(hash(i + float3(0,1,1)), hash(i + float3(1,1,1)), f.x), f.y), f.z);
}

float fbm(float3 p) {
    float v = 0.0, a = 0.5;
    for (int i = 0; i < 4; i++) { v += a * noise(p); a *= 0.5; p *= 2.0; }
    return v;
}

float sdSphere(float3 p, float r) { return length(p) - r; }
float sdTorus(float3 p, float2 t) { return length(float2(length(p.xz) - t.x, p.y)) - t.y; }

float orbSDF(float3 p, float m, float t, float a) {
    float ang = t * 0.2;
    float3 rp = float3(p.x * cos(ang) - p.z * sin(ang), p.y, p.x * sin(ang) + p.z * cos(ang));
    float tilt = 0.4 + sin(t * 0.3) * 0.1;
    rp = float3(rp.x, rp.y * cos(tilt) - rp.z * sin(tilt), rp.y * sin(tilt) + rp.z * cos(tilt));
    float ni = 0.02 + a * 0.06;
    float3 no = float3(fbm(rp * 3.0 + float3(t * 0.5, 0, 0)), fbm(rp * 3.0 + float3(0, t * 0.5, 0)), fbm(rp * 3.0 + float3(0, 0, t * 0.5)));
    float3 dp = rp + no * ni;
    return mix(sdTorus(dp, float2(0.35, 0.12)), sdSphere(dp, 0.38), m) + (fbm(rp * 8.0 + t * 0.3) - 0.5) * 0.01 * (1.0 + a);
}

float3 calcN(float3 p, float m, float t, float a) {
    float2 e = float2(0.001, 0);
    return normalize(float3(orbSDF(p + e.xyy, m, t, a) - orbSDF(p - e.xyy, m, t, a),
                           orbSDF(p + e.yxy, m, t, a) - orbSDF(p - e.yxy, m, t, a),
                           orbSDF(p + e.yyx, m, t, a) - orbSDF(p - e.yyx, m, t, a)));
}

kernel void siriOrbShader(texture2d<float, access::write> output [[texture(0)]], constant float &time [[buffer(0)]],
    constant float &audioLevel [[buffer(1)]], constant float2 &resolution [[buffer(2)]], uint2 gid [[thread_position_in_grid]]) {
    if (gid.x >= uint(resolution.x) || gid.y >= uint(resolution.y)) return;
    float2 uv = (float2(gid) - resolution * 0.5) / min(resolution.x, resolution.y);
    uv.y = -uv.y;
    float3 ro = float3(0, 0, 1.8), rd = normalize(float3(uv, -1));
    float m = smoothstep(0.0, 1.0, audioLevel);
    float t = 0.0;
    bool hit = false;
    float3 p;
    int steps = 0;
    for (int i = 0; i < 100; i++) {
        p = ro + rd * t;
        float d = orbSDF(p, m, time, audioLevel);
        if (d < 0.001) { hit = true; steps = i; break; }
        if (t > 10.0) break;
        t += d * 0.8;
        steps = i;
    }
    float3 bg = float3(0.98) - float3(0.03) * length(uv) * 0.3;
    float3 col = bg;
    if (hit) {
        float3 n = calcN(p, m, time, audioLevel), v = normalize(ro - p);
        float fr = pow(1.0 - max(dot(v, n), 0.0), 3.0);
        float ior = 1.45;
        float3 rR = refract(-rd, n, 1.0/(ior-0.04)), rG = refract(-rd, n, 1.0/ior), rB = refract(-rd, n, 1.0/(ior+0.04));
        float3 cR = mix(float3(0.83,0.87,0.93), float3(0.83,0.64,0.45), clamp(rR.y*0.5+0.5+rR.x*0.3,0.0,1.0));
        float3 cG = mix(float3(0.66,0.77,0.85), float3(0.95,0.90,0.82), clamp(rG.y*0.5+0.5+rG.x*0.3,0.0,1.0));
        float3 cB = mix(float3(0.55,0.70,0.80), float3(0.55,0.37,0.24), clamp(rB.y*0.5+0.5+rB.x*0.3,0.0,1.0));
        float3 refr = float3(cR.r, cG.g, cB.b);
        float3 refl = mix(float3(0.85,0.9,0.95), float3(0.95,0.92,0.88), clamp(reflect(-rd,n).y*0.5+0.5,0.0,1.0));
        col = mix(refr, refl, fr * 0.5);
        col = mix(col, float3(0.3,0.35,0.4), pow(fr,1.5)*0.4);
        float3 l1 = normalize(float3(1,1,1)), l2 = normalize(float3(-0.5,0.8,0.3));
        col += pow(max(dot(n, normalize(l1+v)),0.0), 80.0) * 0.8 + pow(max(dot(n, normalize(l2+v)),0.0), 60.0) * 0.5;
        col += float3(0.6,0.75,0.9) * smoothstep(0.5,0.0,length(p)) * audioLevel * 0.3;
        col += float3(0.7,0.85,1.0) * max(0.0, dot(-l1, n)) * 0.15 * (1.0 + audioLevel);
        col *= 1.0 - float(steps) / 100.0 * 0.3;
    }
    col = pow(clamp(col * (1.0 - length(uv) * 0.2), 0.0, 1.0), float3(1.0/2.2));
    output.write(float4(col, 1.0), gid);
}
"""

// MARK: - Preview

#if DEBUG
#Preview("Siri Orb - Demo") {
    ZStack {
        Color.white.ignoresSafeArea()
        
        VStack(spacing: 20) {
            HaploSiriOrb.demo(size: 200)
            
            Text("Simulated audio reactivity")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview("Siri Orb - Live") {
    ZStack {
        Color.white.ignoresSafeArea()
        
        VStack(spacing: 20) {
            HaploSiriOrb(size: 200, isListening: true)
            
            Text("Speak or make noise to see the orb react")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
#endif
