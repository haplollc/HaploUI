import SwiftUI

public struct ButtonsCatalog: View {
    @State private var isLoading = false
    @State private var segmentSelection = "Option 1"
    @State private var iconSegmentSelection = 0
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                // Icon Buttons (Glass Circle)
                CatalogSection("Icon Buttons (Glass Circle)") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HStack(spacing: HaploTheme.Spacing.md) {
                            HaploIconButton(systemName: "brain") {}
                            HaploIconButton(systemName: "heart.fill") {}
                            HaploIconButton(systemName: "star.fill") {}
                            HaploIconButton(systemName: "bookmark.fill") {}
                            HaploIconButton(systemName: "ellipsis") {}
                        }
                        
                        // With tints
                        HStack(spacing: HaploTheme.Spacing.md) {
                            HaploIconButton(systemName: "heart.fill", tint: .red) {}
                            HaploIconButton(systemName: "star.fill", tint: .yellow) {}
                            HaploIconButton(systemName: "leaf.fill", tint: .green) {}
                        }
                    }
                }
                
                // Icon Button Sizes
                CatalogSection("Icon Button Sizes") {
                    HStack(alignment: .bottom, spacing: HaploTheme.Spacing.md) {
                        HaploIconButton(systemName: "plus", size: 28, iconSize: 12) {}
                        HaploIconButton(systemName: "plus", size: 32, iconSize: 14) {}
                        HaploIconButton(systemName: "plus", size: 40, iconSize: 16) {}
                        HaploIconButton(systemName: "plus", size: 48, iconSize: 20) {}
                    }
                }
                
                // Capsule Buttons (Glass Capsule)
                CatalogSection("Capsule Buttons (Glass Capsule)") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HStack(spacing: HaploTheme.Spacing.md) {
                            HaploCapsuleButton("Filter") {}
                            HaploCapsuleButton("Sort", systemImage: "arrow.up.arrow.down") {}
                        }
                        
                        HStack(spacing: HaploTheme.Spacing.md) {
                            HaploCapsuleButton("Add", systemImage: "plus") {}
                            HaploCapsuleButton("Share", systemImage: "square.and.arrow.up") {}
                        }
                        
                        // With tints
                        HStack(spacing: HaploTheme.Spacing.md) {
                            HaploCapsuleButton("Active", tint: .blue) {}
                            HaploCapsuleButton("Warning", tint: .orange) {}
                        }
                    }
                }
                
                // Primary Buttons (Filled Capsule)
                CatalogSection("Primary Buttons (Filled)") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploPrimaryButton("Get Started") {}
                        HaploPrimaryButton("Continue", systemImage: "arrow.right") {}
                        HaploPrimaryButton("Download", systemImage: "arrow.down.circle") {}
                    }
                }
                
                // Loading State
                CatalogSection("Loading State") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploPrimaryButton("Submit", isLoading: isLoading) {}
                        
                        HaploSecondaryButton(isLoading ? "Stop Loading" : "Start Loading") {
                            isLoading.toggle()
                        }
                    }
                }
                
                // Secondary Buttons (Outline Capsule)
                CatalogSection("Secondary Buttons (Outline)") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploSecondaryButton("Cancel") {}
                        HaploSecondaryButton("Learn More", systemImage: "info.circle") {}
                        HaploSecondaryButton("View Details", systemImage: "chevron.right") {}
                    }
                }
                
                // Tertiary Buttons (Text Only)
                CatalogSection("Tertiary Buttons (Text)") {
                    HStack(spacing: HaploTheme.Spacing.lg) {
                        HaploTertiaryButton("Skip") {}
                        HaploTertiaryButton("Settings", systemImage: "gear") {}
                        HaploTertiaryButton("Help", systemImage: "questionmark.circle") {}
                    }
                }
                
                // Destructive Buttons
                CatalogSection("Destructive Buttons") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploDestructiveButton("Delete Account") {}
                        HaploDestructiveButton("Remove", systemImage: "trash") {}
                    }
                }
                
                // Segmented Control
                CatalogSection("Segmented Control") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploSegmentedControl(
                            options: ["Option 1", "Option 2", "Option 3"],
                            selection: $segmentSelection
                        )
                        
                        HaploSegmentedControl(
                            options: ["Day", "Week", "Month", "Year"],
                            selection: .constant("Week")
                        )
                    }
                }
                
                // Icon Segmented Control
                CatalogSection("Icon Segmented Control") {
                    HaploIconSegmentedControl(
                        options: [0, 1, 2],
                        selection: $iconSegmentSelection,
                        optionIcons: { option in
                            switch option {
                            case 0: return "list.bullet"
                            case 1: return "square.grid.2x2"
                            case 2: return "map"
                            default: return "circle"
                            }
                        }
                    )
                }
                
                // Button Combinations
                CatalogSection("Common Patterns") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        // Primary + Secondary pair
                        HStack(spacing: HaploTheme.Spacing.md) {
                            HaploSecondaryButton("Cancel") {}
                            HaploPrimaryButton("Confirm") {}
                        }
                        
                        // Toolbar pattern
                        HStack(spacing: HaploTheme.Spacing.sm) {
                            HaploIconButton(systemName: "arrow.left") {}
                            Spacer()
                            HaploIconButton(systemName: "heart") {}
                            HaploIconButton(systemName: "square.and.arrow.up") {}
                            HaploIconButton(systemName: "ellipsis") {}
                        }
                        .padding(.horizontal)
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
