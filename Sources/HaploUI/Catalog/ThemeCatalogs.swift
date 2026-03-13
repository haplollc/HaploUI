import SwiftUI

// MARK: - Colors Catalog

public struct ColorsCatalog: View {
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Semantic Text Colors (from Barrier)") {
                    VStack(spacing: HaploTheme.Spacing.sm) {
                        ColorRow("text1 - Primary", color: .text1)
                        ColorRow("text2 - Secondary", color: .text2)
                        ColorRow("text3 - Tertiary", color: .text3)
                    }
                }
                
                CatalogSection("Semantic Background Colors") {
                    VStack(spacing: HaploTheme.Spacing.sm) {
                        ColorRow("background1 - Primary", color: .background1)
                        ColorRow("background2 - Secondary", color: .background2)
                        ColorRow("background3 - Tertiary", color: .background3)
                    }
                }
                
                CatalogSection("Utility Colors") {
                    VStack(spacing: HaploTheme.Spacing.sm) {
                        ColorRow("Shadow", color: .shadow)
                    }
                }
                
                CatalogSection("Goblin Mode Theme") {
                    VStack(spacing: HaploTheme.Spacing.sm) {
                        ColorRow("goblinText1", color: .goblinText1)
                        ColorRow("goblinText2", color: .goblinText2)
                        ColorRow("goblinText3", color: .goblinText3)
                        ColorRow("goblinBackground1", color: .goblinBackground1)
                        ColorRow("goblinBackground2", color: .goblinBackground2)
                        ColorRow("goblinBackground3", color: .goblinBackground3)
                        ColorRow("goblinAccent", color: .goblinAccent)
                    }
                }
                
                CatalogSection("Theme Constants") {
                    VStack(spacing: HaploTheme.Spacing.sm) {
                        ColorRow("Primary", color: HaploTheme.Colors.primary)
                        ColorRow("Secondary", color: HaploTheme.Colors.secondary)
                        ColorRow("Accent", color: HaploTheme.Colors.accent)
                        ColorRow("Success", color: HaploTheme.Colors.success)
                        ColorRow("Warning", color: HaploTheme.Colors.warning)
                        ColorRow("Error", color: HaploTheme.Colors.error)
                    }
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(Color.background1)
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
                .font(.haploBody())
            
            Spacer()
        }
        .padding(HaploTheme.Spacing.sm)
        .background(Color.background2)
        .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md))
    }
}

// MARK: - Typography Catalog

public struct TypographyCatalog: View {
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Dynamic Type Fonts (from Barrier)") {
                    VStack(alignment: .leading, spacing: HaploTheme.Spacing.md) {
                        TypographyRow("haploLargeTitle", font: .haploLargeTitle())
                        TypographyRow("haploTitle", font: .haploTitle())
                        TypographyRow("haploTitle2", font: .haploTitle2())
                        TypographyRow("haploTitle3", font: .haploTitle3())
                        TypographyRow("haploHeadline", font: .haploHeadline())
                        TypographyRow("haploBody", font: .haploBody())
                        TypographyRow("haploCallout", font: .haploCallout())
                        TypographyRow("haploSubheadline", font: .haploSubheadline())
                        TypographyRow("haploFootnote", font: .haploFootnote())
                        TypographyRow("haploCaption", font: .haploCaption())
                        TypographyRow("haploCaption2", font: .haploCaption2())
                    }
                }
                
                CatalogSection("Font Weights") {
                    VStack(alignment: .leading, spacing: HaploTheme.Spacing.md) {
                        TypographyRow("Body Light", font: .haploBody(.light))
                        TypographyRow("Body Regular", font: .haploBody(.regular))
                        TypographyRow("Body Medium", font: .haploBody(.medium))
                        TypographyRow("Body Semibold", font: .haploBody(.semibold))
                        TypographyRow("Body Bold", font: .haploBody(.bold))
                    }
                }
                
                CatalogSection("Special Fonts") {
                    VStack(alignment: .leading, spacing: HaploTheme.Spacing.md) {
                        TypographyRow("Monospaced", font: .haploMono())
                        TypographyRow("Rounded", font: .haploRounded())
                        TypographyRow("Serif", font: .haploSerif())
                        TypographyRow("Fixed (16pt)", font: .haploFixed(16))
                    }
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(Color.background1)
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
                .font(.haploCaption())
                .foregroundColor(.text3)
            Text("The quick brown fox")
                .font(font)
                .foregroundColor(.text1)
        }
        .padding(HaploTheme.Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.background2)
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
        .background(Color.background1)
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
                .font(.haploBody())
                .frame(width: 50, alignment: .leading)
            
            Text("\(Int(value))pt")
                .font(.haploCaption())
                .foregroundColor(.text2)
                .frame(width: 40)
            
            Rectangle()
                .fill(HaploTheme.Colors.primary)
                .frame(width: value, height: 20)
            
            Spacer()
        }
        .padding(HaploTheme.Spacing.sm)
        .background(Color.background2)
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
                .font(.haploBody())
                .frame(width: 50, alignment: .leading)
            
            Text("\(Int(value))pt")
                .font(.haploCaption())
                .foregroundColor(.text2)
                .frame(width: 40)
            
            RoundedRectangle(cornerRadius: value)
                .fill(HaploTheme.Colors.primary)
                .frame(width: 60, height: 40)
            
            Spacer()
        }
        .padding(HaploTheme.Spacing.sm)
        .background(Color.background2)
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
