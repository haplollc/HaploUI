import SwiftUI

public struct TextCatalog: View {
    @State private var selectedChip = "All"
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Text Styles") {
                    VStack(alignment: .leading, spacing: HaploTheme.Spacing.sm) {
                        HaploText("Large Title", style: .largeTitle)
                        HaploText("Title", style: .title)
                        HaploText("Title 2", style: .title2)
                        HaploText("Title 3", style: .title3)
                        HaploText("Headline", style: .headline)
                        HaploText("Body", style: .body)
                        HaploText("Callout", style: .callout)
                        HaploText("Subheadline", style: .subheadline)
                        HaploText("Footnote", style: .footnote)
                        HaploText("Caption", style: .caption)
                        HaploText("Caption 2", style: .caption2)
                    }
                }
                
                CatalogSection("Text Colors") {
                    VStack(alignment: .leading, spacing: HaploTheme.Spacing.sm) {
                        HaploText("Primary Label", color: HaploTheme.Colors.label)
                        HaploText("Secondary Label", color: HaploTheme.Colors.secondaryLabel)
                        HaploText("Tertiary Label", color: HaploTheme.Colors.tertiaryLabel)
                        HaploText("Primary Color", color: HaploTheme.Colors.primary)
                        HaploText("Success Color", color: HaploTheme.Colors.success)
                        HaploText("Error Color", color: HaploTheme.Colors.error)
                    }
                }
                
                CatalogSection("Labels with Icons") {
                    VStack(alignment: .leading, spacing: HaploTheme.Spacing.md) {
                        HaploLabel("Settings", icon: "gear")
                        HaploLabel("Notifications", icon: "bell.fill", iconColor: HaploTheme.Colors.warning)
                        HaploLabel("Profile", icon: "person.fill", iconColor: HaploTheme.Colors.primary)
                        HaploLabel("Download", icon: "arrow.down.circle.fill", style: .headline, iconColor: HaploTheme.Colors.success)
                    }
                }
                
                CatalogSection("Badges") {
                    HStack(spacing: HaploTheme.Spacing.md) {
                        HaploBadge("New", size: .small)
                        HaploBadge("Featured", size: .medium)
                        HaploBadge("Popular", color: HaploTheme.Colors.secondary, size: .large)
                    }
                    
                    HStack(spacing: HaploTheme.Spacing.md) {
                        HaploBadge("Success", color: HaploTheme.Colors.success)
                        HaploBadge("Warning", color: HaploTheme.Colors.warning)
                        HaploBadge("Error", color: HaploTheme.Colors.error)
                    }
                }
                
                CatalogSection("Chips") {
                    let chips = ["All", "Running", "Weights", "Cardio"]
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: HaploTheme.Spacing.sm) {
                            ForEach(chips, id: \.self) { chip in
                                HaploChip(chip, isSelected: selectedChip == chip) {
                                    selectedChip = chip
                                }
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: HaploTheme.Spacing.sm) {
                            HaploChip("Filter", icon: "line.3.horizontal.decrease.circle") {}
                            HaploChip("Sort", icon: "arrow.up.arrow.down") {}
                            HaploChip("Add", icon: "plus") {}
                        }
                    }
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
        .navigationTitle("Text & Labels")
    }
}

#Preview {
    NavigationStack {
        TextCatalog()
    }
}
