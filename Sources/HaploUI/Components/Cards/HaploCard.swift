import SwiftUI

// MARK: - Card

public struct HaploCard<Content: View>: View {
    let content: Content
    let padding: CGFloat
    let cornerRadius: CGFloat
    let hasShadow: Bool
    
    public init(
        padding: CGFloat = HaploTheme.Spacing.lg,
        cornerRadius: CGFloat = HaploTheme.CornerRadius.lg,
        hasShadow: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.padding = padding
        self.cornerRadius = cornerRadius
        self.hasShadow = hasShadow
        self.content = content()
    }
    
    public var body: some View {
        content
            .padding(padding)
            .background(HaploTheme.Colors.background)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .if(hasShadow) { view in
                view.haploShadow(HaploTheme.Shadows.md)
            }
    }
}

// MARK: - Info Card

public struct HaploInfoCard: View {
    let title: String
    let subtitle: String?
    let icon: String?
    let iconColor: Color
    let action: (() -> Void)?
    
    public init(
        title: String,
        subtitle: String? = nil,
        icon: String? = nil,
        iconColor: Color = HaploTheme.Colors.primary,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.iconColor = iconColor
        self.action = action
    }
    
    public var body: some View {
        HStack(spacing: HaploTheme.Spacing.md) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(iconColor)
                    .frame(width: 44, height: 44)
                    .background(iconColor.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md))
            }
            
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xxs) {
                Text(title)
                    .font(HaploTheme.Typography.headline)
                    .foregroundColor(HaploTheme.Colors.label)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(HaploTheme.Typography.subheadline)
                        .foregroundColor(HaploTheme.Colors.secondaryLabel)
                }
            }
            
            Spacer()
            
            if action != nil {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(HaploTheme.Colors.tertiaryLabel)
            }
        }
        .padding(HaploTheme.Spacing.lg)
        .background(HaploTheme.Colors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.lg))
        .if(action != nil) { view in
            view.onTapGesture { action?() }
        }
    }
}

// MARK: - Stat Card

public struct HaploStatCard: View {
    let title: String
    let value: String
    let subtitle: String?
    let icon: String?
    let trend: Trend?
    let accentColor: Color
    
    public enum Trend {
        case up(String)
        case down(String)
        case neutral(String)
        
        var color: Color {
            switch self {
            case .up: return HaploTheme.Colors.success
            case .down: return HaploTheme.Colors.error
            case .neutral: return HaploTheme.Colors.secondaryLabel
            }
        }
        
        var icon: String {
            switch self {
            case .up: return "arrow.up.right"
            case .down: return "arrow.down.right"
            case .neutral: return "arrow.right"
            }
        }
        
        var text: String {
            switch self {
            case .up(let t), .down(let t), .neutral(let t): return t
            }
        }
    }
    
    public init(
        title: String,
        value: String,
        subtitle: String? = nil,
        icon: String? = nil,
        trend: Trend? = nil,
        accentColor: Color = HaploTheme.Colors.primary
    ) {
        self.title = title
        self.value = value
        self.subtitle = subtitle
        self.icon = icon
        self.trend = trend
        self.accentColor = accentColor
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: HaploTheme.Spacing.md) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundColor(accentColor)
                }
                
                Text(title)
                    .font(HaploTheme.Typography.subheadline)
                    .foregroundColor(HaploTheme.Colors.secondaryLabel)
                
                Spacer()
            }
            
            Text(value)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(HaploTheme.Colors.label)
            
            if let trend = trend {
                HStack(spacing: HaploTheme.Spacing.xxs) {
                    Image(systemName: trend.icon)
                        .font(.system(size: 12, weight: .semibold))
                    Text(trend.text)
                        .font(HaploTheme.Typography.caption)
                }
                .foregroundColor(trend.color)
            }
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(HaploTheme.Typography.caption)
                    .foregroundColor(HaploTheme.Colors.tertiaryLabel)
            }
        }
        .padding(HaploTheme.Spacing.lg)
        .background(HaploTheme.Colors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.lg))
    }
}

// MARK: - View Extension

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
