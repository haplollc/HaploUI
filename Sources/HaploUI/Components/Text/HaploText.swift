import SwiftUI

// MARK: - Text Styles

public enum HaploTextStyle {
    case largeTitle
    case title
    case title2
    case title3
    case headline
    case body
    case callout
    case subheadline
    case footnote
    case caption
    case caption2
    
    var font: Font {
        switch self {
        case .largeTitle: return HaploTheme.Typography.largeTitle
        case .title: return HaploTheme.Typography.title
        case .title2: return HaploTheme.Typography.title2
        case .title3: return HaploTheme.Typography.title3
        case .headline: return HaploTheme.Typography.headline
        case .body: return HaploTheme.Typography.body
        case .callout: return HaploTheme.Typography.callout
        case .subheadline: return HaploTheme.Typography.subheadline
        case .footnote: return HaploTheme.Typography.footnote
        case .caption: return HaploTheme.Typography.caption
        case .caption2: return HaploTheme.Typography.caption2
        }
    }
}

// MARK: - Haplo Text

public struct HaploText: View {
    let text: String
    let style: HaploTextStyle
    let color: Color
    let alignment: TextAlignment
    let lineLimit: Int?
    
    public init(
        _ text: String,
        style: HaploTextStyle = .body,
        color: Color = HaploTheme.Colors.label,
        alignment: TextAlignment = .leading,
        lineLimit: Int? = nil
    ) {
        self.text = text
        self.style = style
        self.color = color
        self.alignment = alignment
        self.lineLimit = lineLimit
    }
    
    public var body: some View {
        Text(text)
            .font(style.font)
            .foregroundColor(color)
            .multilineTextAlignment(alignment)
            .lineLimit(lineLimit)
    }
}

// MARK: - Label with Icon

public struct HaploLabel: View {
    let text: String
    let icon: String
    let style: HaploTextStyle
    let color: Color
    let iconColor: Color?
    
    public init(
        _ text: String,
        icon: String,
        style: HaploTextStyle = .body,
        color: Color = HaploTheme.Colors.label,
        iconColor: Color? = nil
    ) {
        self.text = text
        self.icon = icon
        self.style = style
        self.color = color
        self.iconColor = iconColor
    }
    
    public var body: some View {
        Label {
            Text(text)
                .font(style.font)
                .foregroundColor(color)
        } icon: {
            Image(systemName: icon)
                .foregroundColor(iconColor ?? color)
        }
    }
}

// MARK: - Badge

public struct HaploBadge: View {
    let text: String
    let color: Color
    let size: BadgeSize
    
    public enum BadgeSize {
        case small, medium, large
        
        var font: Font {
            switch self {
            case .small: return .caption2.weight(.semibold)
            case .medium: return .caption.weight(.semibold)
            case .large: return .subheadline.weight(.semibold)
            }
        }
        
        var horizontalPadding: CGFloat {
            switch self {
            case .small: return 6
            case .medium: return 8
            case .large: return 10
            }
        }
        
        var verticalPadding: CGFloat {
            switch self {
            case .small: return 2
            case .medium: return 4
            case .large: return 6
            }
        }
    }
    
    public init(
        _ text: String,
        color: Color = HaploTheme.Colors.primary,
        size: BadgeSize = .medium
    ) {
        self.text = text
        self.color = color
        self.size = size
    }
    
    public var body: some View {
        Text(text)
            .font(size.font)
            .foregroundColor(.white)
            .padding(.horizontal, size.horizontalPadding)
            .padding(.vertical, size.verticalPadding)
            .background(color)
            .clipShape(Capsule())
    }
}

// MARK: - Chip

public struct HaploChip: View {
    let text: String
    let icon: String?
    let isSelected: Bool
    let action: () -> Void
    
    public init(
        _ text: String,
        icon: String? = nil,
        isSelected: Bool = false,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.icon = icon
        self.isSelected = isSelected
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: HaploTheme.Spacing.xs) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 12))
                }
                Text(text)
                    .font(HaploTheme.Typography.subheadline)
            }
            .foregroundColor(isSelected ? .white : HaploTheme.Colors.label)
            .padding(.horizontal, HaploTheme.Spacing.md)
            .padding(.vertical, HaploTheme.Spacing.sm)
            .background(isSelected ? HaploTheme.Colors.primary : HaploTheme.Colors.secondaryBackground)
            .clipShape(Capsule())
        }
        .buttonStyle(HaploButtonPressStyle())
    }
}
