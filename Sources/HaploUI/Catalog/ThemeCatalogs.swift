import SwiftUI

// MARK: - Colors Catalog

public struct ColorsCatalog: View {
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Primary Colors") {
                    VStack(spacing: HaploTheme.Spacing.sm) {
                        ColorRow("Primary", color: HaploTheme.Colors.primary)
                        ColorRow("Secondary", color: HaploTheme.Colors.secondary)
                        ColorRow("Accent", color: HaploTheme.Colors.accent)
                    }
                }
                
                CatalogSection("Semantic Colors") {
                    VStack(spacing: HaploTheme.Spacing.sm) {
                        ColorRow("Success", color: HaploTheme.Colors.success)
                        ColorRow("Warning", color: HaploTheme.Colors.warning)
                        ColorRow("Error", color: HaploTheme.Colors.error)
                    }
                }
                
                CatalogSection("Background Colors") {
                    VStack(spacing: HaploTheme.Spacing.sm) {
                        ColorRow("Background", color: HaploTheme.Colors.background)
                        ColorRow("Secondary BG", color: HaploTheme.Colors.secondaryBackground)
                        ColorRow("Tertiary BG", color: HaploTheme.Colors.tertiaryBackground)
                    }
                }
                
                CatalogSection("Label Colors") {
                    VStack(spacing: HaploTheme.Spacing.sm) {
                        ColorRow("Label", color: HaploTheme.Colors.label)
                        ColorRow("Secondary Label", color: HaploTheme.Colors.secondaryLabel)
                        ColorRow("Tertiary Label", color: HaploTheme.Colors.tertiaryLabel)
                    }
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
        .navigationTitle("Colors")
    }
}

struct ColorRow: View {
    let name: String
    let color: Color
    
    init(_ name: String, color: Color) {
        self.name = name
        self.color = color
    }
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: 44, height: 44)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            
            Text(name)
                .font(HaploTheme.Typography.body)
            
            Spacer()
        }
        .padding(HaploTheme.Spacing.sm)
        .background(HaploTheme.Colors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md))
    }
}

// MARK: - Typography Catalog

public struct TypographyCatalog: View {
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Typography Scale") {
                    VStack(alignment: .leading, spacing: HaploTheme.Spacing.md) {
                        TypographyRow("Large Title", font: HaploTheme.Typography.largeTitle)
                        TypographyRow("Title", font: HaploTheme.Typography.title)
                        TypographyRow("Title 2", font: HaploTheme.Typography.title2)
                        TypographyRow("Title 3", font: HaploTheme.Typography.title3)
                        TypographyRow("Headline", font: HaploTheme.Typography.headline)
                        TypographyRow("Body", font: HaploTheme.Typography.body)
                        TypographyRow("Callout", font: HaploTheme.Typography.callout)
                        TypographyRow("Subheadline", font: HaploTheme.Typography.subheadline)
                        TypographyRow("Footnote", font: HaploTheme.Typography.footnote)
                        TypographyRow("Caption", font: HaploTheme.Typography.caption)
                        TypographyRow("Caption 2", font: HaploTheme.Typography.caption2)
                    }
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
        .navigationTitle("Typography")
    }
}

struct TypographyRow: View {
    let name: String
    let font: Font
    
    init(_ name: String, font: Font) {
        self.name = name
        self.font = font
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: HaploTheme.Spacing.xxs) {
            Text(name)
                .font(font)
            Text("The quick brown fox jumps over the lazy dog")
                .font(font)
                .foregroundColor(HaploTheme.Colors.secondaryLabel)
        }
        .padding(HaploTheme.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(HaploTheme.Colors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md))
    }
}

// MARK: - Spacing Catalog

public struct SpacingCatalog: View {
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Spacing Scale") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        SpacingRow("xxs", value: HaploTheme.Spacing.xxs)
                        SpacingRow("xs", value: HaploTheme.Spacing.xs)
                        SpacingRow("sm", value: HaploTheme.Spacing.sm)
                        SpacingRow("md", value: HaploTheme.Spacing.md)
                        SpacingRow("lg", value: HaploTheme.Spacing.lg)
                        SpacingRow("xl", value: HaploTheme.Spacing.xl)
                        SpacingRow("xxl", value: HaploTheme.Spacing.xxl)
                        SpacingRow("xxxl", value: HaploTheme.Spacing.xxxl)
                    }
                }
                
                CatalogSection("Corner Radius") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        RadiusRow("sm", value: HaploTheme.CornerRadius.sm)
                        RadiusRow("md", value: HaploTheme.CornerRadius.md)
                        RadiusRow("lg", value: HaploTheme.CornerRadius.lg)
                        RadiusRow("xl", value: HaploTheme.CornerRadius.xl)
                    }
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
        .navigationTitle("Spacing")
    }
}

struct SpacingRow: View {
    let name: String
    let value: CGFloat
    
    init(_ name: String, value: CGFloat) {
        self.name = name
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(name)
                .font(HaploTheme.Typography.body)
                .frame(width: 50, alignment: .leading)
            
            Text("\(Int(value))pt")
                .font(HaploTheme.Typography.caption)
                .foregroundColor(HaploTheme.Colors.secondaryLabel)
                .frame(width: 40)
            
            Rectangle()
                .fill(HaploTheme.Colors.primary)
                .frame(width: value, height: 20)
            
            Spacer()
        }
        .padding(HaploTheme.Spacing.sm)
        .background(HaploTheme.Colors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md))
    }
}

struct RadiusRow: View {
    let name: String
    let value: CGFloat
    
    init(_ name: String, value: CGFloat) {
        self.name = name
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(name)
                .font(HaploTheme.Typography.body)
                .frame(width: 50, alignment: .leading)
            
            Text("\(Int(value))pt")
                .font(HaploTheme.Typography.caption)
                .foregroundColor(HaploTheme.Colors.secondaryLabel)
                .frame(width: 40)
            
            RoundedRectangle(cornerRadius: value)
                .fill(HaploTheme.Colors.primary)
                .frame(width: 60, height: 40)
            
            Spacer()
        }
        .padding(HaploTheme.Spacing.sm)
        .background(HaploTheme.Colors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md))
    }
}

#Preview("Colors") {
    NavigationStack {
        ColorsCatalog()
    }
}

#Preview("Typography") {
    NavigationStack {
        TypographyCatalog()
    }
}

#Preview("Spacing") {
    NavigationStack {
        SpacingCatalog()
    }
}
