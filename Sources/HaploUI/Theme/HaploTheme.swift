import SwiftUI

// MARK: - Theme

public struct HaploTheme {
    
    // MARK: - Colors
    
    public struct Colors {
        public static let primary = Color.blue
        public static let secondary = Color.purple
        public static let accent = Color.orange
        public static let success = Color.green
        public static let warning = Color.yellow
        public static let error = Color.red
        
        public static let background = Color(uiColor: .systemBackground)
        public static let secondaryBackground = Color(uiColor: .secondarySystemBackground)
        public static let tertiaryBackground = Color(uiColor: .tertiarySystemBackground)
        
        public static let label = Color(uiColor: .label)
        public static let secondaryLabel = Color(uiColor: .secondaryLabel)
        public static let tertiaryLabel = Color(uiColor: .tertiaryLabel)
    }
    
    // MARK: - Spacing
    
    public struct Spacing {
        public static let xxs: CGFloat = 2
        public static let xs: CGFloat = 4
        public static let sm: CGFloat = 8
        public static let md: CGFloat = 12
        public static let lg: CGFloat = 16
        public static let xl: CGFloat = 24
        public static let xxl: CGFloat = 32
        public static let xxxl: CGFloat = 48
    }
    
    // MARK: - Corner Radius
    
    public struct CornerRadius {
        public static let sm: CGFloat = 6
        public static let md: CGFloat = 10
        public static let lg: CGFloat = 16
        public static let xl: CGFloat = 24
        public static let full: CGFloat = 9999
    }
    
    // MARK: - Typography
    
    public struct Typography {
        public static let largeTitle = Font.largeTitle.weight(.bold)
        public static let title = Font.title.weight(.semibold)
        public static let title2 = Font.title2.weight(.semibold)
        public static let title3 = Font.title3.weight(.medium)
        public static let headline = Font.headline
        public static let body = Font.body
        public static let callout = Font.callout
        public static let subheadline = Font.subheadline
        public static let footnote = Font.footnote
        public static let caption = Font.caption
        public static let caption2 = Font.caption2
    }
    
    // MARK: - Shadows
    
    public struct Shadows {
        public static let sm = Shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        public static let md = Shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 2)
        public static let lg = Shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
    
    public struct Shadow {
        public let color: Color
        public let radius: CGFloat
        public let x: CGFloat
        public let y: CGFloat
    }
    
    // MARK: - Animation
    
    public struct Animation {
        public static let quick = SwiftUI.Animation.easeOut(duration: 0.15)
        public static let standard = SwiftUI.Animation.easeInOut(duration: 0.25)
        public static let smooth = SwiftUI.Animation.easeInOut(duration: 0.35)
        public static let spring = SwiftUI.Animation.spring(response: 0.35, dampingFraction: 0.7)
        public static let bouncy = SwiftUI.Animation.spring(response: 0.4, dampingFraction: 0.6)
    }
}

// MARK: - View Extensions

public extension View {
    func haploShadow(_ shadow: HaploTheme.Shadow) -> some View {
        self.shadow(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
    }
}
