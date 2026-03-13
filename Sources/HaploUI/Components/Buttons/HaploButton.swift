//
//  HaploButton.swift
//  HaploUI
//
//  Button components from Haplo production apps (Chalk, Barrier).
//

import SwiftUI

// MARK: - Icon Button (Glass Circle)

/// A glass circle icon button, matching Chalk's `.glassCircle()` pattern.
public struct HaploIconButton: View {
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
