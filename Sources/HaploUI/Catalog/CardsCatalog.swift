import SwiftUI

public struct CardsCatalog: View {
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Basic Card") {
                        Text("Container for grouping related content")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploCard {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Card Title")
                                    .font(.haploHeadline(.bold))
                                    .foregroundStyle(Color.text1)
                                Text("This is some content inside a card. Cards are useful for grouping related content and creating visual hierarchy.")
                                    .font(.haploBody())
                                    .foregroundStyle(Color.text2)
                            }
                        }
                    }
                    
                    CatalogSection("Card Without Shadow") {
                        Text("Flat style for subtle separation")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploCard(hasShadow: false) {
                            Text("No shadow card - uses border instead")
                                .font(.haploBody())
                                .foregroundStyle(Color.text2)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.background3, lineWidth: 1)
                        )
                    }
                    
                    CatalogSection("Info Cards") {
                        Text("Settings-style rows with icons")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
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
                        Text("Display metrics with trends")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ], spacing: 12) {
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
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Cards")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
    }
}

#Preview {
    NavigationStack {
        CardsCatalog()
    }
}
