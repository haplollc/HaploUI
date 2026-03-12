import SwiftUI

public struct ButtonsCatalog: View {
    @State private var isLoading = false
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                // Button Styles
                CatalogSection("Button Styles") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploButton("Primary", style: .primary) {}
                        HaploButton("Secondary", style: .secondary) {}
                        HaploButton("Tertiary", style: .tertiary) {}
                        HaploButton("Destructive", style: .destructive) {}
                        HaploButton("Ghost", style: .ghost) {}
                        HaploButton("Outline", style: .outline) {}
                    }
                }
                
                // Button Sizes
                CatalogSection("Button Sizes") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploButton("Small", size: .small) {}
                        HaploButton("Medium", size: .medium) {}
                        HaploButton("Large", size: .large) {}
                    }
                }
                
                // With Icons
                CatalogSection("With Icons") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploButton("Add Item", icon: "plus") {}
                        HaploButton("Download", icon: "arrow.down.circle") {}
                        HaploButton("Share", icon: "square.and.arrow.up", style: .secondary) {}
                        HaploButton("Delete", icon: "trash", style: .destructive) {}
                    }
                }
                
                // Full Width
                CatalogSection("Full Width") {
                    HaploButton("Continue", icon: "arrow.right", isFullWidth: true) {}
                }
                
                // Loading State
                CatalogSection("Loading State") {
                    HStack {
                        HaploButton("Submit", isLoading: isLoading) {}
                        
                        Button(isLoading ? "Stop" : "Start") {
                            isLoading.toggle()
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                // Icon Buttons
                CatalogSection("Icon Buttons") {
                    HStack(spacing: HaploTheme.Spacing.md) {
                        HaploIconButton(icon: "heart.fill", style: .primary) {}
                        HaploIconButton(icon: "bookmark.fill", style: .secondary) {}
                        HaploIconButton(icon: "ellipsis", style: .tertiary) {}
                        HaploIconButton(icon: "xmark", style: .ghost) {}
                    }
                }
                
                // Icon Button Sizes
                CatalogSection("Icon Button Sizes") {
                    HStack(spacing: HaploTheme.Spacing.md) {
                        HaploIconButton(icon: "plus", size: .small) {}
                        HaploIconButton(icon: "plus", size: .medium) {}
                        HaploIconButton(icon: "plus", size: .large) {}
                    }
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
        .navigationTitle("Buttons")
    }
}

#Preview {
    NavigationStack {
        ButtonsCatalog()
    }
}
