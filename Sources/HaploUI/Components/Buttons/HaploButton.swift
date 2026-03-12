import SwiftUI

// MARK: - Button Styles

public enum HaploButtonStyle {
    case primary
    case secondary
    case tertiary
    case destructive
    case ghost
    case outline
}

public enum HaploButtonSize {
    case small
    case medium
    case large
    
    var verticalPadding: CGFloat {
        switch self {
        case .small: return 8
        case .medium: return 12
        case .large: return 16
        }
    }
    
    var horizontalPadding: CGFloat {
        switch self {
        case .small: return 12
        case .medium: return 20
        case .large: return 28
        }
    }
    
    var font: Font {
        switch self {
        case .small: return .subheadline.weight(.medium)
        case .medium: return .body.weight(.semibold)
        case .large: return .headline.weight(.semibold)
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .small: return 14
        case .medium: return 18
        case .large: return 22
        }
    }
}

// MARK: - Haplo Button

public struct HaploButton: View {
    let title: String
    let icon: String?
    let style: HaploButtonStyle
    let size: HaploButtonSize
    let isFullWidth: Bool
    let isLoading: Bool
    let action: () -> Void
    
    public init(
        _ title: String,
        icon: String? = nil,
        style: HaploButtonStyle = .primary,
        size: HaploButtonSize = .medium,
        isFullWidth: Bool = false,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.style = style
        self.size = size
        self.isFullWidth = isFullWidth
        self.isLoading = isLoading
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: HaploTheme.Spacing.sm) {
                if isLoading {
                    ProgressView()
                        .tint(foregroundColor)
                } else {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: size.iconSize))
                    }
                    Text(title)
                }
            }
            .font(size.font)
            .foregroundColor(foregroundColor)
            .padding(.vertical, size.verticalPadding)
            .padding(.horizontal, size.horizontalPadding)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md))
            .overlay(
                RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md)
                    .stroke(borderColor, lineWidth: style == .outline ? 1.5 : 0)
            )
        }
        .buttonStyle(HaploButtonPressStyle())
        .disabled(isLoading)
    }
    
    private var backgroundColor: Color {
        switch style {
        case .primary: return HaploTheme.Colors.primary
        case .secondary: return HaploTheme.Colors.secondary
        case .tertiary: return HaploTheme.Colors.secondaryBackground
        case .destructive: return HaploTheme.Colors.error
        case .ghost, .outline: return .clear
        }
    }
    
    private var foregroundColor: Color {
        switch style {
        case .primary, .secondary, .destructive: return .white
        case .tertiary: return HaploTheme.Colors.label
        case .ghost: return HaploTheme.Colors.primary
        case .outline: return HaploTheme.Colors.primary
        }
    }
    
    private var borderColor: Color {
        switch style {
        case .outline: return HaploTheme.Colors.primary
        default: return .clear
        }
    }
}

// MARK: - Icon Button

public struct HaploIconButton: View {
    let icon: String
    let style: HaploButtonStyle
    let size: HaploButtonSize
    let action: () -> Void
    
    public init(
        icon: String,
        style: HaploButtonStyle = .tertiary,
        size: HaploButtonSize = .medium,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.style = style
        self.size = size
        self.action = action
    }
    
    private var buttonSize: CGFloat {
        switch size {
        case .small: return 32
        case .medium: return 44
        case .large: return 56
        }
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: size.iconSize))
                .foregroundColor(foregroundColor)
                .frame(width: buttonSize, height: buttonSize)
                .background(backgroundColor)
                .clipShape(Circle())
        }
        .buttonStyle(HaploButtonPressStyle())
    }
    
    private var backgroundColor: Color {
        switch style {
        case .primary: return HaploTheme.Colors.primary
        case .secondary: return HaploTheme.Colors.secondary
        case .tertiary: return HaploTheme.Colors.secondaryBackground
        case .destructive: return HaploTheme.Colors.error
        case .ghost, .outline: return .clear
        }
    }
    
    private var foregroundColor: Color {
        switch style {
        case .primary, .secondary, .destructive: return .white
        case .tertiary: return HaploTheme.Colors.label
        case .ghost, .outline: return HaploTheme.Colors.primary
        }
    }
}

// MARK: - Press Style

struct HaploButtonPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(HaploTheme.Animation.quick, value: configuration.isPressed)
    }
}
