//
//  HaploEffects.swift
//  HaploUI
//
//  Visual effects extracted from Haplo production apps.
//  Original sources: chalk, barrier_swiftui, haplo_invest
//

import SwiftUI

// MARK: - Glass Effects (from Chalk)

public extension View {
    /// Apply glass effect in a circle shape (iOS 26+) or fallback to ultra thin material
    @ViewBuilder
    func glassCircle(tint: Color? = nil) -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            if let tint = tint {
                self
                    .tint(tint)
                    .glassEffect(in: .circle)
            } else {
                self.glassEffect(in: .circle)
            }
        } else {
            self
                .background(
                    Circle()
                        .fill(.ultraThinMaterial)
                )
                .background(
                    Circle()
                        .fill(Color.secondary.opacity(0.12))
                )
        }
    }
    
    /// Apply glass effect in a capsule shape (iOS 26+) or fallback to ultra thin material
    @ViewBuilder
    func glassCapsule(tint: Color? = nil) -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            if let tint = tint {
                self
                    .tint(tint)
                    .glassEffect(in: .capsule)
            } else {
                self.glassEffect(in: .capsule)
            }
        } else {
            self
                .background(
                    Capsule()
                        .fill(.ultraThinMaterial)
                )
                .background(
                    Capsule()
                        .fill(Color.secondary.opacity(0.12))
                )
        }
    }
    
    /// Apply glass effect in a rounded rectangle shape
    @ViewBuilder
    func glassCard(cornerRadius: CGFloat = HaploTheme.CornerRadius.lg, tint: Color? = nil) -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            if let tint = tint {
                self
                    .tint(tint)
                    .glassEffect(in: .rect(cornerRadius: cornerRadius))
            } else {
                self.glassEffect(in: .rect(cornerRadius: cornerRadius))
            }
        } else {
            self
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial)
                )
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.secondary.opacity(0.12))
                )
        }
    }
}

// MARK: - Shimmer Views (from Chalk)

/// A shimmer loading effect view that can be used as a placeholder
public struct HaploShimmerView: View {
    @State private var phase: CGFloat = 0

    public init() {}
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.secondary.opacity(0.12)

                // Shimmer gradient
                LinearGradient(
                    colors: [
                        Color.clear,
                        Color.secondary.opacity(0.25),
                        Color.clear
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: geometry.size.width * 2)
                .offset(x: phase * geometry.size.width * 3 - geometry.size.width * 2)
            }
        }
        .onAppear {
            withAnimation(
                .linear(duration: 1.5)
                .repeatForever(autoreverses: false)
            ) {
                phase = 1
            }
        }
    }
}

/// Text with a sweeping shimmer highlight effect
public struct HaploShimmerText: View {
    let text: String
    @State private var phase: CGFloat = 0

    public init(_ text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .foregroundColor(.secondary.opacity(0.4))
            .overlay {
                GeometryReader { geo in
                    LinearGradient(
                        colors: [
                            .clear,
                            .secondary.opacity(0.7),
                            .clear
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geo.size.width * 0.4)
                    .offset(x: phase * geo.size.width * 1.4 - geo.size.width * 0.4)
                }
                .mask(Text(text))
            }
            .onAppear {
                withAnimation(
                    .linear(duration: 1.5)
                    .repeatForever(autoreverses: false)
                ) {
                    phase = 1
                }
            }
    }
}

/// A map-specific shimmer with a map icon overlay
public struct HaploMapShimmer: View {
    public init() {}
    
    public var body: some View {
        ZStack {
            HaploShimmerView()

            Image(systemName: "map")
                .font(.title2)
                .foregroundColor(.secondary.opacity(0.3))
        }
    }
}

// MARK: - Shimmer Modifier

public struct HaploShimmerModifier: ViewModifier {
    let isAnimating: Bool
    
    @State private var phase: CGFloat = 0
    
    public init(isAnimating: Bool = true) {
        self.isAnimating = isAnimating
    }
    
    private let gradient = Gradient(colors: [
        .black.opacity(0.3),
        .black,
        .black.opacity(0.3)
    ])
    
    private let bandSize: CGFloat = 0.3
    
    public func body(content: Content) -> some View {
        content
            .mask(
                LinearGradient(
                    gradient: gradient,
                    startPoint: UnitPoint(x: phase - bandSize, y: phase - bandSize),
                    endPoint: UnitPoint(x: phase + bandSize, y: phase + bandSize)
                )
            )
            .onAppear {
                guard isAnimating else { return }
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 1 + bandSize
                }
            }
    }
}

public extension View {
    func shimmer(isAnimating: Bool = true) -> some View {
        self.modifier(HaploShimmerModifier(isAnimating: isAnimating))
    }
}

// MARK: - Skeleton Loading

public struct HaploSkeleton: View {
    let width: CGFloat?
    let height: CGFloat
    let cornerRadius: CGFloat
    
    public init(
        width: CGFloat? = nil,
        height: CGFloat = 20,
        cornerRadius: CGFloat = HaploTheme.CornerRadius.sm
    ) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(HaploTheme.Colors.secondaryBackground)
            .frame(width: width, height: height)
            .shimmer()
    }
}

// MARK: - Blink Effect (from Haplo Invest)

public struct HaploBlinkModifier: ViewModifier {
    let duration: Double
    @State private var blinking: Bool = false
    @State private var timer: Timer?

    public init(duration: Double = 0.7) {
        self.duration = duration
    }
    
    public func body(content: Content) -> some View {
        content
            .redacted(reason: .placeholder)
            .opacity(blinking ? 0.3 : 1)
            .onAppear {
                startBlinking()
            }
            .onDisappear {
                timer?.invalidate()
                timer = nil
            }
    }

    private func startBlinking() {
        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
            var transaction = Transaction()
            transaction.animation = Animation.linear(duration: duration)
            withTransaction(transaction) {
                blinking.toggle()
            }
        }
    }
}

public extension View {
    func blinking(duration: Double = 0.7) -> some View {
        modifier(HaploBlinkModifier(duration: duration))
    }
}

// MARK: - Default Shadow (from Chalk/Barrier)

public struct HaploDefaultShadowModifier: ViewModifier {
    public init() {}
    
    public func body(content: Content) -> some View {
        content
            .shadow(color: .shadow, radius: 8, x: 1, y: 3)
    }
}

public extension View {
    func defaultShadow() -> some View {
        self.modifier(HaploDefaultShadowModifier())
    }
}

// MARK: - Card Style (from Chalk)

public struct HaploCardModifier: ViewModifier {
    let cornerRadius: CGFloat
    
    public init(cornerRadius: CGFloat = HaploTheme.CornerRadius.lg) {
        self.cornerRadius = cornerRadius
    }
    
    public func body(content: Content) -> some View {
        content
            .background(Color.background1)
            .cornerRadius(cornerRadius)
            .defaultShadow()
    }
}

public extension View {
    func cardStyle(cornerRadius: CGFloat = HaploTheme.CornerRadius.lg) -> some View {
        self.modifier(HaploCardModifier(cornerRadius: cornerRadius))
    }
}

// MARK: - Haptic Feedback

public extension View {
    #if os(iOS)
    func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) -> some View {
        self.modifier(HapticModifier(style: style))
    }
    
    func hapticSelection() -> some View {
        self.modifier(SelectionHapticModifier())
    }
    
    func hapticNotification(_ type: UINotificationFeedbackGenerator.FeedbackType) -> some View {
        self.modifier(NotificationHapticModifier(type: type))
    }
    #else
    func haptic(_ style: Any) -> some View { self }
    func hapticSelection() -> some View { self }
    func hapticNotification(_ type: Any) -> some View { self }
    #endif
}

#if os(iOS)
struct HapticModifier: ViewModifier {
    let style: UIImpactFeedbackGenerator.FeedbackStyle
    
    func body(content: Content) -> some View {
        content.simultaneousGesture(
            TapGesture().onEnded { _ in
                UIImpactFeedbackGenerator(style: style).impactOccurred()
            }
        )
    }
}

struct SelectionHapticModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.simultaneousGesture(
            TapGesture().onEnded { _ in
                UISelectionFeedbackGenerator().selectionChanged()
            }
        )
    }
}

struct NotificationHapticModifier: ViewModifier {
    let type: UINotificationFeedbackGenerator.FeedbackType
    
    func body(content: Content) -> some View {
        content.simultaneousGesture(
            TapGesture().onEnded { _ in
                UINotificationFeedbackGenerator().notificationOccurred(type)
            }
        )
    }
}
#endif

// MARK: - Typing Effect (from Haplo Invest)

public struct HaploTypingModifier: ViewModifier {
    let text: AttributedString
    let characterDelay: Double
    
    @State private var animatedText: AttributedString = ""

    public init(text: AttributedString, characterDelay: Double = 0.005) {
        self.text = text
        self.characterDelay = characterDelay
    }
    
    public func body(content: Content) -> some View {
        Text(animatedText)
            .onAppear {
                animateText()
            }
    }
    
    private func animateText() {
        var currentIndex = text.startIndex
        
        func appendNextCharacter() {
            guard currentIndex < text.endIndex else { return }
            
            let nextIndex = text.index(afterCharacter: currentIndex)
            let character = text[currentIndex..<nextIndex]
            animatedText.append(AttributedString(character))
            currentIndex = nextIndex
            
            DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay) {
                appendNextCharacter()
            }
        }
        
        appendNextCharacter()
    }
}

public extension View {
    func typingAnimation(text: AttributedString, characterDelay: Double = 0.005) -> some View {
        self.modifier(HaploTypingModifier(text: text, characterDelay: characterDelay))
    }
}

// MARK: - Conditional View Modifiers

public extension View {
    /// Apply a transformation only when the condition is true
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Apply a transformation to a view
    @ViewBuilder
    func apply<Content: View>(@ViewBuilder transform: (Self) -> Content) -> some View {
        transform(self)
    }
    
    /// Unwrap an optional and apply transform if non-nil
    @ViewBuilder
    func ifLet<T, Content: View>(_ value: T?, transform: (Self, T) -> Content) -> some View {
        if let value {
            transform(self, value)
        } else {
            self
        }
    }
}
