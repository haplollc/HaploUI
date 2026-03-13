import SwiftUI

// MARK: - Sheet Styles

public enum HaploSheetStyle {
    case standard
    case compact
    case fullscreen
    case card
}

// MARK: - Sheet Container

public struct HaploSheet<Content: View>: View {
    let title: String?
    let subtitle: String?
    let style: HaploSheetStyle
    let showDragIndicator: Bool
    let showCloseButton: Bool
    let onDismiss: (() -> Void)?
    let content: Content
    
    public init(
        title: String? = nil,
        subtitle: String? = nil,
        style: HaploSheetStyle = .standard,
        showDragIndicator: Bool = true,
        showCloseButton: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.subtitle = subtitle
        self.style = style
        self.showDragIndicator = showDragIndicator
        self.showCloseButton = showCloseButton
        self.onDismiss = onDismiss
        self.content = content()
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Drag indicator
            if showDragIndicator && style != .fullscreen {
                RoundedRectangle(cornerRadius: 2.5)
                    .fill(Color.secondary.opacity(0.5))
                    .frame(width: 36, height: 5)
                    .padding(.top, HaploTheme.Spacing.sm)
                    .padding(.bottom, HaploTheme.Spacing.md)
            }
            
            // Header
            if title != nil || showCloseButton {
                HStack {
                    VStack(alignment: .leading, spacing: HaploTheme.Spacing.xxs) {
                        if let title = title {
                            Text(title)
                                .font(HaploTheme.Typography.title3)
                                .foregroundColor(HaploTheme.Colors.label)
                        }
                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(HaploTheme.Typography.subheadline)
                                .foregroundColor(HaploTheme.Colors.secondaryLabel)
                        }
                    }
                    
                    Spacer()
                    
                    if showCloseButton {
                        HaploGlassIconButton(systemName: "xmark", size: 28, iconSize: 12) {
                            onDismiss?()
                        }
                    }
                }
                .padding(.horizontal, HaploTheme.Spacing.lg)
                .padding(.bottom, HaploTheme.Spacing.md)
            }
            
            // Content
            content
        }
        .background(HaploTheme.Colors.background)
    }
}

// MARK: - Action Sheet

public struct HaploActionSheet: View {
    public struct Action: Identifiable {
        public let id = UUID()
        let title: String
        let icon: String?
        let style: ActionStyle
        let action: () -> Void
        
        public enum ActionStyle {
            case `default`
            case destructive
            case cancel
        }
        
        public init(
            title: String,
            icon: String? = nil,
            style: ActionStyle = .default,
            action: @escaping () -> Void
        ) {
            self.title = title
            self.icon = icon
            self.style = style
            self.action = action
        }
    }
    
    let title: String?
    let message: String?
    let actions: [Action]
    
    public init(
        title: String? = nil,
        message: String? = nil,
        actions: [Action]
    ) {
        self.title = title
        self.message = message
        self.actions = actions
    }
    
    public var body: some View {
        VStack(spacing: HaploTheme.Spacing.md) {
            // Drag indicator
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.secondary.opacity(0.5))
                .frame(width: 36, height: 5)
                .padding(.top, HaploTheme.Spacing.sm)
            
            // Header
            if title != nil || message != nil {
                VStack(spacing: HaploTheme.Spacing.xs) {
                    if let title = title {
                        Text(title)
                            .font(HaploTheme.Typography.headline)
                            .foregroundColor(HaploTheme.Colors.label)
                    }
                    if let message = message {
                        Text(message)
                            .font(HaploTheme.Typography.subheadline)
                            .foregroundColor(HaploTheme.Colors.secondaryLabel)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal, HaploTheme.Spacing.lg)
            }
            
            // Actions
            VStack(spacing: HaploTheme.Spacing.sm) {
                ForEach(actions) { action in
                    Button {
                        action.action()
                    } label: {
                        HStack(spacing: HaploTheme.Spacing.md) {
                            if let icon = action.icon {
                                Image(systemName: icon)
                                    .font(.system(size: 18))
                            }
                            Text(action.title)
                                .font(HaploTheme.Typography.body)
                            Spacer()
                        }
                        .foregroundColor(action.style == .destructive ? HaploTheme.Colors.error : HaploTheme.Colors.label)
                        .padding(.vertical, HaploTheme.Spacing.md)
                        .padding(.horizontal, HaploTheme.Spacing.lg)
                        .background(HaploTheme.Colors.secondaryBackground)
                        .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md))
                    }
                    .buttonStyle(HaploButtonPressStyle())
                }
            }
            .padding(.horizontal, HaploTheme.Spacing.lg)
            .padding(.bottom, HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
    }
}

// MARK: - Confirmation Sheet

public struct HaploConfirmationSheet: View {
    let title: String
    let message: String
    let confirmTitle: String
    let isDestructive: Bool
    let cancelTitle: String
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
    public init(
        title: String,
        message: String,
        confirmTitle: String = "Confirm",
        confirmStyle: ConfirmStyle = .primary,
        cancelTitle: String = "Cancel",
        onConfirm: @escaping () -> Void,
        onCancel: @escaping () -> Void
    ) {
        self.title = title
        self.message = message
        self.confirmTitle = confirmTitle
        self.isDestructive = confirmStyle == .destructive
        self.cancelTitle = cancelTitle
        self.onConfirm = onConfirm
        self.onCancel = onCancel
    }
    
    public enum ConfirmStyle {
        case primary
        case destructive
    }
    
    public var body: some View {
        VStack(spacing: HaploTheme.Spacing.lg) {
            // Drag indicator
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.secondary.opacity(0.5))
                .frame(width: 36, height: 5)
                .padding(.top, HaploTheme.Spacing.sm)
            
            // Content
            VStack(spacing: HaploTheme.Spacing.sm) {
                Text(title)
                    .font(HaploTheme.Typography.title3)
                    .foregroundColor(HaploTheme.Colors.label)
                
                Text(message)
                    .font(HaploTheme.Typography.body)
                    .foregroundColor(HaploTheme.Colors.secondaryLabel)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, HaploTheme.Spacing.lg)
            
            // Buttons
            HStack(spacing: HaploTheme.Spacing.md) {
                HaploSecondaryButton(cancelTitle) {
                    onCancel()
                }
                
                if isDestructive {
                    HaploDestructiveButton(confirmTitle) {
                        onConfirm()
                    }
                } else {
                    HaploPrimaryButton(confirmTitle) {
                        onConfirm()
                    }
                }
            }
            .padding(.horizontal, HaploTheme.Spacing.lg)
            .padding(.bottom, HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
    }
}
