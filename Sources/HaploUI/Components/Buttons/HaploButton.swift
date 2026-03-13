//
//  HaploButton.swift
//  HaploUI
//
//  Button components from Haplo production apps (Chalk, Barrier).
//

import SwiftUI

// MARK: - Button Style Enum

public enum HaploButtonStyle {
    case primary
    case secondary
    case tertiary
    case destructive
    case ghost
    case outline
}

// MARK: - Button Size Enum

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
        case .medium: return 16
        case .large: return 24
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .small: return 13
        case .medium: return 15
        case .large: return 17
        }
    }
}

// MARK: - Unified HaploButton

/// A unified button component with multiple styles and sizes.
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
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .scaleEffect(0.8)
                        .tint(foregroundColor)
                } else if let icon {
                    Image(systemName: icon)
                        .font(.system(size: size.fontSize - 2, weight: .medium))
                }
                Text(title)
                    .font(.system(size: size.fontSize, weight: .semibold))
            }
            .foregroundColor(foregroundColor)
            .padding(.vertical, size.verticalPadding)
            .padding(.horizontal, size.horizontalPadding)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .background(backgroundView)
        }
        .buttonStyle(HaploButtonPressStyle())
        .disabled(isLoading)
    }
    
    private var foregroundColor: Color {
        switch style {
        case .primary, .destructive:
            return .white
        case .secondary, .outline:
            return Color.text1
        case .tertiary, .ghost:
            return HaploTheme.Colors.primary
        }
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        switch style {
        case .primary:
            Capsule().fill(HaploTheme.Colors.primary)
        case .secondary:
            Capsule().fill(Color.background3)
        case .tertiary:
            Capsule().fill(Color.clear)
        case .destructive:
            Capsule().fill(HaploTheme.Colors.error)
        case .ghost:
            Capsule().fill(Color.clear)
        case .outline:
            Capsule().strokeBorder(Color.text3, lineWidth: 1)
        }
    }
}

// MARK: - Unified HaploIconButton

/// A unified icon button component with multiple styles and sizes.
public struct HaploIconButton: View {
    let icon: String
    let style: HaploButtonStyle
    let size: HaploButtonSize
    let action: () -> Void
    
    public init(
        icon: String,
        style: HaploButtonStyle = .primary,
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
        case .medium: return 40
        case .large: return 48
        }
    }
    
    private var iconSize: CGFloat {
        switch size {
        case .small: return 14
        case .medium: return 18
        case .large: return 22
        }
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: iconSize, weight: .medium))
                .foregroundColor(foregroundColor)
                .frame(width: buttonSize, height: buttonSize)
                .background(backgroundView)
                .clipShape(Circle())
        }
        .buttonStyle(HaploButtonPressStyle())
    }
    
    private var foregroundColor: Color {
        switch style {
        case .primary, .destructive:
            return .white
        case .secondary, .outline:
            return Color.text1
        case .tertiary, .ghost:
            return HaploTheme.Colors.primary
        }
    }
    
    @ViewBuilder
    private var backgroundView: some View {
        switch style {
        case .primary:
            HaploTheme.Colors.primary
        case .secondary:
            Color.background3
        case .tertiary:
            Color.background2
        case .destructive:
            HaploTheme.Colors.error
        case .ghost:
            Color.clear
        case .outline:
            Color.clear
        }
    }
}

// MARK: - Glass Icon Button (Legacy)

/// A glass circle icon button, matching Chalk's `.glassCircle()` pattern.
/// Use for sheets and legacy glass-style UI.
public struct HaploGlassIconButton: View {
    let systemName: String
    let action: () -> Void
    var tint: Color?
    var size: CGFloat
    var iconSize: CGFloat
    
    public init(
        systemName: String,
        tint: Color? = nil,
        size: CGFloat = 32,
        iconSize: CGFloat = 14,
        action: @escaping () -> Void
    ) {
        self.systemName = systemName
        self.tint = tint
        self.size = size
        self.iconSize = iconSize
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: iconSize, weight: .medium))
                .foregroundColor(.primary)
                .frame(width: size, height: size)
                .glassCircle(tint: tint)
        }
        .buttonStyle(.plain)
    }
}

// Type alias for backward compatibility with HaploSheet
public typealias HaploSheetIconButton = HaploGlassIconButton

// MARK: - Capsule Button (Glass Capsule)

/// A glass capsule button with optional icon, matching Chalk's `.glassCapsule()` pattern.
public struct HaploCapsuleButton: View {
    let title: String
    let systemImage: String?
    let action: () -> Void
    var tint: Color?
    
    public init(
        _ title: String,
        systemImage: String? = nil,
        tint: Color? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.tint = tint
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
            }
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .glassCapsule(tint: tint)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Primary Button (Filled Capsule)

/// A filled primary button with optional loading state, matching Chalk's Generate button pattern.
public struct HaploPrimaryButton: View {
    let title: String
    let systemImage: String?
    let action: () -> Void
    var isLoading: Bool
    
    public init(
        _ title: String,
        systemImage: String? = nil,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.isLoading = isLoading
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .scaleEffect(0.8)
                        .tint(.white)
                } else if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
            }
            .font(HaploTheme.Typography.body)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(HaploTheme.Colors.primary)
            .clipShape(Capsule())
        }
        .buttonStyle(HaploButtonPressStyle())
        .disabled(isLoading)
    }
}

// MARK: - Secondary Button (Outline Capsule)

/// An outline capsule button for secondary actions.
public struct HaploSecondaryButton: View {
    let title: String
    let systemImage: String?
    let action: () -> Void
    
    public init(
        _ title: String,
        systemImage: String? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
            }
            .font(HaploTheme.Typography.body)
            .fontWeight(.medium)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                Capsule()
                    .strokeBorder(Color.primary.opacity(0.3), lineWidth: 1)
            )
        }
        .buttonStyle(HaploButtonPressStyle())
    }
}

// MARK: - Tertiary Button (Text Only)

/// A text-only button for tertiary actions.
public struct HaploTertiaryButton: View {
    let title: String
    let systemImage: String?
    let action: () -> Void
    
    public init(
        _ title: String,
        systemImage: String? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
            }
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(HaploTheme.Colors.primary)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Destructive Button (Filled Red)

/// A destructive button for dangerous actions.
public struct HaploDestructiveButton: View {
    let title: String
    let systemImage: String?
    let action: () -> Void
    var isLoading: Bool
    
    public init(
        _ title: String,
        systemImage: String? = nil,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.isLoading = isLoading
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .scaleEffect(0.8)
                        .tint(.white)
                } else if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
            }
            .font(HaploTheme.Typography.body)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(HaploTheme.Colors.error)
            .clipShape(Capsule())
        }
        .buttonStyle(HaploButtonPressStyle())
        .disabled(isLoading)
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
