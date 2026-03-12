import SwiftUI

public struct CardsCatalog: View {
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Basic Card") {
                    HaploCard {
                        VStack(alignment: .leading, spacing: HaploTheme.Spacing.md) {
                            Text("Card Title")
                                .font(HaploTheme.Typography.headline)
                            Text("This is some content inside a card. Cards are useful for grouping related content.")
                                .font(HaploTheme.Typography.body)
                                .foregroundColor(HaploTheme.Colors.secondaryLabel)
                        }
                    }
                }
                
                CatalogSection("Card Without Shadow") {
                    HaploCard(hasShadow: false) {
                        Text("No shadow card")
                            .font(HaploTheme.Typography.body)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.lg)
                            .stroke(HaploTheme.Colors.secondaryBackground, lineWidth: 1)
                    )
                }
                
                CatalogSection("Info Cards") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploInfoCard(
                            title: "Settings",
                            subtitle: "Manage your preferences",
                            icon: "gear"
                        ) {}
                        
                        HaploInfoCard(
                            title: "Notifications",
                            subtitle: "3 new notifications",
                            icon: "bell.fill",
                            iconColor: HaploTheme.Colors.warning
                        ) {}
                        
                        HaploInfoCard(
                            title: "Profile",
                            icon: "person.fill",
                            iconColor: HaploTheme.Colors.secondary
                        )
                    }
                }
                
                CatalogSection("Stat Cards") {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: HaploTheme.Spacing.md) {
                        HaploStatCard(
                            title: "Workouts",
                            value: "24",
                            trend: .up("+12%"),
                            accentColor: HaploTheme.Colors.primary
                        )
                        
                        HaploStatCard(
                            title: "Calories",
                            value: "1,842",
                            subtitle: "This week",
                            icon: "flame.fill",
                            trend: .up("+8%"),
                            accentColor: HaploTheme.Colors.warning
                        )
                        
                        HaploStatCard(
                            title: "Distance",
                            value: "12.5",
                            subtitle: "Miles this month",
                            icon: "figure.run",
                            trend: .down("-3%"),
                            accentColor: HaploTheme.Colors.success
                        )
                        
                        HaploStatCard(
                            title: "Streak",
                            value: "7",
                            subtitle: "Days",
                            icon: "star.fill",
                            accentColor: HaploTheme.Colors.secondary
                        )
                    }
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
        .navigationTitle("Cards")
    }
}

#Preview {
    NavigationStack {
        CardsCatalog()
    }
}
