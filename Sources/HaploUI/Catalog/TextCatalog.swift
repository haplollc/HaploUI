import SwiftUI

public struct TextCatalog: View {
    @State private var selectedChip = "All"
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Text Styles") {
                        Text("Dynamic Type scalable typography")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8) {
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
                        Text("Semantic color hierarchy")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HaploText("text1 - Primary", color: .text1)
                            HaploText("text2 - Secondary", color: .text2)
                            HaploText("text3 - Tertiary", color: .text3)
                            HaploText("Primary Accent", color: HaploTheme.Colors.primary)
                            HaploText("Success", color: HaploTheme.Colors.success)
                            HaploText("Error", color: HaploTheme.Colors.error)
                        }
                    }
                    
                    CatalogSection("Labels with Icons") {
                        Text("Icon + text combinations")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HaploLabel("Settings", icon: "gear")
                            HaploLabel("Notifications", icon: "bell.fill", iconColor: HaploTheme.Colors.warning)
                            HaploLabel("Profile", icon: "person.fill", iconColor: HaploTheme.Colors.primary)
                            HaploLabel("Download", icon: "arrow.down.circle.fill", style: .headline, iconColor: HaploTheme.Colors.success)
                        }
                    }
                    
                    CatalogSection("Badges") {
                        Text("Status indicators and counts")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 12) {
                                HaploBadge("New", size: .small)
                                HaploBadge("Featured", size: .medium)
                                HaploBadge("Popular", color: HaploTheme.Colors.secondary, size: .large)
                            }
                            
                            HStack(spacing: 12) {
                                HaploBadge("Success", color: HaploTheme.Colors.success)
                                HaploBadge("Warning", color: HaploTheme.Colors.warning)
                                HaploBadge("Error", color: HaploTheme.Colors.error)
                            }
                        }
                    }
                    
                    CatalogSection("Chips") {
                        Text("Selectable filter options")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        let chips = ["All", "Running", "Weights", "Cardio"]
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(chips, id: \.self) { chip in
                                        HaploChip(chip, isSelected: selectedChip == chip) {
                                            withAnimation(.spring(response: 0.3)) {
                                                selectedChip = chip
                                            }
                                        }
                                    }
                                }
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    HaploChip("Filter", icon: "line.3.horizontal.decrease.circle") {}
                                    HaploChip("Sort", icon: "arrow.up.arrow.down") {}
                                    HaploChip("Add", icon: "plus") {}
                                }
                            }
                        }
                    }
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Text & Labels")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
    }
}

#Preview {
    NavigationStack {
        TextCatalog()
    }
}
