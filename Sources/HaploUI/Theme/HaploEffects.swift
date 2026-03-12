import SwiftUI

// MARK: - Glass Effects

public extension View {
    /// Apply glass effect in a circle shape (iOS 26+) or fallback to ultra thin material
    @ViewBuilder
    func glassCircle(tint: Color? = nil) -> some View {
        if #available(iOS 26.0, *) {
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
        if #available(iOS 26.0, *) {
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
        if #available(iOS 26.0, *) {
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

// MARK: - Shimmer Effect

public struct HaploShimmer: ViewModifier {
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
        self.modifier(HaploShimmer(isAnimating: isAnimating))
    }
}

// MARK: - Skeleton Loading

public struct HaploSkeleton: View {
    let width: CGFloat?
    let height: CGFloat
    let cornerRadius: CGFloat
    
    @State private var isAnimating = false
    
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

// MARK: - Haptic Feedback

public extension View {
    func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) -> some View {
        self.modifier(HapticModifier(style: style))
    }
    
    func hapticSelection() -> some View {
        self.modifier(SelectionHapticModifier())
    }
    
    func hapticNotification(_ type: UINotificationFeedbackGenerator.FeedbackType) -> some View {
        self.modifier(NotificationHapticModifier(type: type))
    }
}

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
