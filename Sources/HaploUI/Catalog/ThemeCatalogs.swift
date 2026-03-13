import SwiftUI

// MARK: - Colors Catalog

public struct ColorsCatalog: View {
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Text Colors") {
                        Text("Semantic text hierarchy from Barrier")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 8) {
                            ColorRow("text1 - Primary", color: .text1, description: "Main content, headlines")
                            ColorRow("text2 - Secondary", color: .text2, description: "Supporting text, labels")
                            ColorRow("text3 - Tertiary", color: .text3, description: "Hints, metadata, captions")
                        }
                    }
                    
                    CatalogSection("Background Colors") {
                        Text("Layered surface hierarchy")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 8) {
                            ColorRow("background1 - Primary", color: .background1, description: "Main app background")
                            ColorRow("background2 - Secondary", color: .background2, description: "Cards, elevated surfaces")
                            ColorRow("background3 - Tertiary", color: .background3, description: "Nested elements, inputs")
                        }
                    }
                    
                    CatalogSection("Utility Colors") {
                        Text("Shadows and overlays")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ColorRow("Shadow", color: .shadow, description: "Elevation shadows")
                    }
                    
                    CatalogSection("Goblin Mode 👺") {
                        Text("Alternative dark theme")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 8) {
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
                        Text("Accent and semantic colors")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 8) {
                            ColorRow("Primary", color: HaploTheme.Colors.primary, description: "Main accent")
                            ColorRow("Secondary", color: HaploTheme.Colors.secondary, description: "Complementary accent")
                            ColorRow("Accent", color: HaploTheme.Colors.accent, description: "Highlight color")
                            ColorRow("Success", color: HaploTheme.Colors.success, description: "Positive states")
                            ColorRow("Warning", color: HaploTheme.Colors.warning, description: "Caution states")
                            ColorRow("Error", color: HaploTheme.Colors.error, description: "Error states")
                        }
                    }
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Colors")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
    }
}

struct ColorRow: View {
    let name: String
    let color: Color
    var description: String? = nil
    
    init(_ name: String, color: Color, description: String? = nil) {
        self.name = name
        self.color = color
        self.description = description
    }
    
    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .frame(width: 44, height: 44)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.text3.opacity(0.2), lineWidth: 1)
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.haploBody(.medium))
                    .foregroundStyle(Color.text1)
                
                if let description = description {
                    Text(description)
                        .font(.haploCaption())
                        .foregroundStyle(Color.text3)
                }
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color.background3)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Typography Catalog

public struct TypographyCatalog: View {
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Dynamic Type Fonts") {
                        Text("Scales with user preferences")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8) {
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
                        Text("Different emphasis levels")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            TypographyRow("Light", font: .haploBody(.light))
                            TypographyRow("Regular", font: .haploBody(.regular))
                            TypographyRow("Medium", font: .haploBody(.medium))
                            TypographyRow("Semibold", font: .haploBody(.semibold))
                            TypographyRow("Bold", font: .haploBody(.bold))
                        }
                    }
                    
                    CatalogSection("Special Fonts") {
                        Text("Design-specific typefaces")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            TypographyRow("Monospaced", font: .haploMono())
                            TypographyRow("Rounded", font: .haploRounded())
                            TypographyRow("Serif", font: .haploSerif())
                            TypographyRow("Fixed (16pt)", font: .haploFixed(16))
                        }
                    }
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Typography")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
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
        VStack(alignment: .leading, spacing: 4) {
            Text(name)
                .font(.haploCaption())
                .foregroundStyle(Color.text3)
            Text("The quick brown fox")
                .font(font)
                .foregroundStyle(Color.text1)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.background3)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Spacing Catalog

public struct SpacingCatalog: View {
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Spacing Scale") {
                        Text("Consistent spacing tokens")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 8) {
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
                        Text("Consistent roundness tokens")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 8) {
                            RadiusRow("sm", value: HaploTheme.CornerRadius.sm)
                            RadiusRow("md", value: HaploTheme.CornerRadius.md)
                            RadiusRow("lg", value: HaploTheme.CornerRadius.lg)
                            RadiusRow("xl", value: HaploTheme.CornerRadius.xl)
                        }
                    }
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Spacing")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
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
        HStack(spacing: 12) {
            Text(name)
                .font(.haploBody(.medium))
                .foregroundStyle(Color.text1)
                .frame(width: 40, alignment: .leading)
            
            Text("\(Int(value))pt")
                .font(.haploCaption())
                .foregroundStyle(Color.text3)
                .frame(width: 36)
            
            Rectangle()
                .fill(LinearGradient(
                    colors: [HaploTheme.Colors.primary, HaploTheme.Colors.secondary],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .frame(width: value, height: 20)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            
            Spacer()
        }
        .padding(12)
        .background(Color.background3)
        .clipShape(RoundedRectangle(cornerRadius: 12))
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
        HStack(spacing: 12) {
            Text(name)
                .font(.haploBody(.medium))
                .foregroundStyle(Color.text1)
                .frame(width: 40, alignment: .leading)
            
            Text("\(Int(value))pt")
                .font(.haploCaption())
                .foregroundStyle(Color.text3)
                .frame(width: 36)
            
            RoundedRectangle(cornerRadius: value)
                .fill(LinearGradient(
                    colors: [HaploTheme.Colors.primary, HaploTheme.Colors.secondary],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 60, height: 40)
            
            Spacer()
        }
        .padding(12)
        .background(Color.background3)
        .clipShape(RoundedRectangle(cornerRadius: 12))
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
