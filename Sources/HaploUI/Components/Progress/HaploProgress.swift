import SwiftUI

// MARK: - Radial Progress

public struct HaploRadialProgress: View {
    let progress: Double
    let currentStep: Int?
    let totalSteps: Int?
    let lineWidth: CGFloat
    let size: CGFloat
    let accentColor: Color
    let showLabel: Bool
    
    public init(
        progress: Double,
        currentStep: Int? = nil,
        totalSteps: Int? = nil,
        lineWidth: CGFloat = 8,
        size: CGFloat = 80,
        accentColor: Color = HaploTheme.Colors.primary,
        showLabel: Bool = true
    ) {
        self.progress = progress
        self.currentStep = currentStep
        self.totalSteps = totalSteps
        self.lineWidth = lineWidth
        self.size = size
        self.accentColor = accentColor
        self.showLabel = showLabel
    }
    
    public var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(
                    accentColor.opacity(0.3),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
            
            // Progress circle
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    accentColor,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: progress)
            
            // Center label
            if showLabel {
                if let current = currentStep, let total = totalSteps {
                    VStack(spacing: 2) {
                        Text("\(current)")
                            .font(.system(size: size * 0.22, weight: .bold, design: .rounded))
                            .foregroundColor(HaploTheme.Colors.label)
                            .contentTransition(.numericText())
                        
                        Text("/ \(total)")
                            .font(.system(size: size * 0.15, weight: .medium, design: .rounded))
                            .foregroundColor(HaploTheme.Colors.secondaryLabel)
                    }
                } else {
                    Text("\(Int(progress * 100))%")
                        .font(.system(size: size * 0.22, weight: .bold, design: .rounded))
                        .foregroundColor(HaploTheme.Colors.label)
                        .contentTransition(.numericText())
                }
            }
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Linear Progress

public struct HaploLinearProgress: View {
    let progress: Double
    let height: CGFloat
    let accentColor: Color
    let showLabel: Bool
    
    public init(
        progress: Double,
        height: CGFloat = 8,
        accentColor: Color = HaploTheme.Colors.primary,
        showLabel: Bool = false
    ) {
        self.progress = progress
        self.height = height
        self.accentColor = accentColor
        self.showLabel = showLabel
    }
    
    public var body: some View {
        VStack(alignment: .trailing, spacing: HaploTheme.Spacing.xs) {
            if showLabel {
                Text("\(Int(progress * 100))%")
                    .font(HaploTheme.Typography.caption)
                    .foregroundColor(HaploTheme.Colors.secondaryLabel)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background
                    RoundedRectangle(cornerRadius: height / 2)
                        .fill(accentColor.opacity(0.3))
                    
                    // Progress
                    RoundedRectangle(cornerRadius: height / 2)
                        .fill(accentColor)
                        .frame(width: geometry.size.width * progress)
                        .animation(.easeInOut(duration: 0.3), value: progress)
                }
            }
            .frame(height: height)
        }
    }
}

// MARK: - Indeterminate Progress

public struct HaploIndeterminateProgress: View {
    let height: CGFloat
    let accentColor: Color
    
    @State private var isAnimating = false
    
    public init(
        height: CGFloat = 4,
        accentColor: Color = HaploTheme.Colors.primary
    ) {
        self.height = height
        self.accentColor = accentColor
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(accentColor.opacity(0.3))
                
                // Moving indicator
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(accentColor)
                    .frame(width: geometry.size.width * 0.3)
                    .offset(x: isAnimating ? geometry.size.width * 0.7 : 0)
            }
        }
        .frame(height: height)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}

// MARK: - Pulsing Indicator

public struct HaploPulsingIndicator: View {
    let size: CGFloat
    let color: Color
    
    @State private var isPulsing = false
    
    public init(
        size: CGFloat = 12,
        color: Color = HaploTheme.Colors.primary
    ) {
        self.size = size
        self.color = color
    }
    
    public var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
            .scaleEffect(isPulsing ? 1.2 : 0.8)
            .opacity(isPulsing ? 1.0 : 0.6)
            .animation(
                .easeInOut(duration: 0.8).repeatForever(autoreverses: true),
                value: isPulsing
            )
            .onAppear {
                isPulsing = true
            }
    }
}

// MARK: - Three Dot Loading

public struct HaploDotsLoading: View {
    let size: CGFloat
    let color: Color
    
    @State private var animationStep = 0
    
    public init(
        size: CGFloat = 8,
        color: Color = HaploTheme.Colors.primary
    ) {
        self.size = size
        self.color = color
    }
    
    public var body: some View {
        HStack(spacing: size * 0.5) {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .fill(color)
                    .frame(width: size, height: size)
                    .scaleEffect(animationStep == index ? 1.2 : 0.8)
                    .opacity(animationStep == index ? 1.0 : 0.5)
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.2)) {
                    animationStep = (animationStep + 1) % 3
                }
            }
        }
    }
}
