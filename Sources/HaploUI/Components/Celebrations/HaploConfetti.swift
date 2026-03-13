//
//  HaploConfetti.swift
//  HaploUI
//
//  Confetti celebration effect extracted from Haplo production apps.
//  Original source: haplo_invest
//

import SwiftUI
#if os(iOS)
import UIKit
#endif

// MARK: - Single Confetti Piece

public struct HaploConfettiPiece: View {
    @State private var animate = false
    @State private var xSpeed = Double.random(in: 0.7...2)
    @State private var zSpeed = Double.random(in: 1...2)
    @State private var anchor = CGFloat.random(in: 0...1).rounded()
    
    let color: Color
    let size: CGFloat
    
    public init(color: Color = [Color.orange, Color.green, Color.blue, Color.red, Color.yellow].randomElement()!, size: CGFloat = 20) {
        self.color = color
        self.size = size
    }
    
    public var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: size, height: size)
            .onAppear { animate = true }
            .rotation3DEffect(.degrees(animate ? 360 : 0), axis: (x: 1, y: 0, z: 0))
            .animation(.linear(duration: xSpeed).repeatForever(autoreverses: false), value: animate)
            .rotation3DEffect(.degrees(animate ? 360 : 0), axis: (x: 0, y: 0, z: 1), anchor: UnitPoint(x: anchor, y: anchor))
            .animation(.linear(duration: zSpeed).repeatForever(autoreverses: false), value: animate)
    }
}

// MARK: - Confetti Container

public struct HaploConfettiContainer: View {
    let count: Int
    let colors: [Color]
    @State private var positions: [CGPoint] = []
    
    public init(
        count: Int = 50,
        colors: [Color] = [.orange, .green, .blue, .red, .yellow, .purple, .pink]
    ) {
        self.count = count
        self.colors = colors
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<min(count, positions.count), id: \.self) { index in
                    HaploConfettiPiece(color: colors.randomElement()!)
                        .position(positions[index])
                }
            }
            .onAppear {
                positions = (0..<count).map { _ in
                    CGPoint(
                        x: CGFloat.random(in: 0...geometry.size.width),
                        y: CGFloat.random(in: 0...geometry.size.height)
                    )
                }
            }
        }
        .ignoresSafeArea()
    }
}

// MARK: - Confetti View Modifier

public struct HaploConfettiModifier: ViewModifier {
    @Binding var isActive: Bool
    let animationDuration: Double
    let fadeDuration: Double
    let count: Int
    let colors: [Color]
    
    @State private var opacity: Double = 1.0
    
    public init(
        isActive: Binding<Bool>,
        animationDuration: Double = 3.0,
        fadeDuration: Double = 2.0,
        count: Int = 50,
        colors: [Color] = [.orange, .green, .blue, .red, .yellow, .purple, .pink]
    ) {
        self._isActive = isActive
        self.animationDuration = animationDuration
        self.fadeDuration = fadeDuration
        self.count = count
        self.colors = colors
    }
    
    public func body(content: Content) -> some View {
        content
            .overlay {
                if isActive {
                    HaploConfettiContainer(count: count, colors: colors)
                        .opacity(opacity)
                }
            }
            .sensoryFeedback(.success, trigger: isActive)
            .onChange(of: isActive) { _, newValue in
                if newValue {
                    opacity = 1.0
                    startAnimationSequence()
                }
            }
    }
    
    private func startAnimationSequence() {
        Task { @MainActor in
            try? await Task.sleep(for: .seconds(animationDuration))
            withAnimation(.easeOut(duration: fadeDuration)) {
                opacity = 0
            }
            try? await Task.sleep(for: .seconds(fadeDuration))
            isActive = false
            opacity = 1.0
        }
    }
}

public extension View {
    /// Display confetti celebration effect
    /// - Parameters:
    ///   - isActive: Binding to control when confetti is shown
    ///   - count: Number of confetti pieces (default 50)
    ///   - colors: Array of colors for confetti pieces
    func confetti(
        isActive: Binding<Bool>,
        count: Int = 50,
        colors: [Color] = [.orange, .green, .blue, .red, .yellow, .purple, .pink]
    ) -> some View {
        self.modifier(HaploConfettiModifier(isActive: isActive, count: count, colors: colors))
    }
}

// MARK: - Preview

#Preview {
    struct ConfettiDemo: View {
        @State private var showConfetti = false
        
        var body: some View {
            VStack {
                Text("Tap to celebrate!")
                Button("🎉 Confetti!") {
                    showConfetti = true
                }
                .buttonStyle(.borderedProminent)
            }
            .confetti(isActive: $showConfetti)
        }
    }
    
    return ConfettiDemo()
}
