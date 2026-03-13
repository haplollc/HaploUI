import SwiftUI

public struct EffectsCatalog: View {
    @State private var showConfetti = false
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Glass Capsule") {
                    HStack(spacing: HaploTheme.Spacing.md) {
                        Text("Default")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .glassCapsule()
                        
                        Text("Tinted")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .glassCapsule(tint: .blue)
                    }
                }
                
                CatalogSection("Glass Circle") {
                    HStack(spacing: HaploTheme.Spacing.md) {
                        Image(systemName: "heart.fill")
                            .font(.title2)
                            .foregroundColor(.red)
                            .frame(width: 50, height: 50)
                            .glassCircle()
                        
                        Image(systemName: "star.fill")
                            .font(.title2)
                            .foregroundColor(.yellow)
                            .frame(width: 50, height: 50)
                            .glassCircle(tint: .orange)
                    }
                }
                
                CatalogSection("Glass Card") {
                    VStack(alignment: .leading, spacing: HaploTheme.Spacing.sm) {
                        Text("Glass Card")
                            .font(.haploHeadline())
                        Text("Content with a frosted glass effect background.")
                            .font(.haploBody())
                            .foregroundColor(.text2)
                    }
                    .padding(HaploTheme.Spacing.lg)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard()
                }
                
                CatalogSection("Shimmer View (from Chalk)") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        // Full shimmer placeholder
                        HaploShimmerView()
                            .frame(height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        // Shimmer text
                        HaploShimmerText("Loading content...")
                            .font(.haploHeadline())
                        
                        // Map shimmer placeholder
                        HaploMapShimmer()
                            .frame(height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                
                CatalogSection("Shimmer Modifier") {
                    Text("Shimmer text effect")
                        .font(.haploTitle2(.bold))
                        .shimmer()
                }
                
                CatalogSection("Skeleton Loading") {
                    VStack(alignment: .leading, spacing: HaploTheme.Spacing.md) {
                        HaploSkeleton(height: 20)
                        HaploSkeleton(width: 200, height: 16)
                        HaploSkeleton(width: 150, height: 16)
                        
                        HStack(spacing: HaploTheme.Spacing.md) {
                            HaploSkeleton(width: 80, height: 80, cornerRadius: 12)
                            VStack(alignment: .leading, spacing: 8) {
                                HaploSkeleton(height: 18)
                                HaploSkeleton(width: 120, height: 14)
                            }
                        }
                    }
                }
                
                CatalogSection("Blink Effect (from Haplo Invest)") {
                    VStack(spacing: HaploTheme.Spacing.sm) {
                        Text("Loading placeholder")
                            .blinking()
                        
                        HStack(spacing: 12) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.secondary.opacity(0.3))
                                .frame(width: 60, height: 60)
                                .blinking(duration: 0.5)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Title here")
                                    .blinking()
                                Text("Subtitle text")
                                    .font(.caption)
                                    .blinking(duration: 1.0)
                            }
                        }
                    }
                }
                
                CatalogSection("Card Style (from Chalk)") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Card Title")
                            .font(.haploHeadline(.bold))
                        Text("This card uses the cardStyle modifier with default shadow.")
                            .font(.haploBody())
                            .foregroundColor(.text2)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cardStyle()
                }
                
                CatalogSection("Confetti Celebration") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        Text("Tap to celebrate!")
                            .font(.haploBody())
                        
                        HaploButton("🎉 Show Confetti", style: .primary) {
                            showConfetti = true
                        }
                    }
                }
                
                #if os(iOS)
                CatalogSection("Haptic Feedback") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploButton("Light Impact", style: .tertiary) {}
                            .haptic(.light)
                        
                        HaploButton("Medium Impact", style: .tertiary) {}
                            .haptic(.medium)
                        
                        HaploButton("Heavy Impact", style: .tertiary) {}
                            .haptic(.heavy)
                        
                        HaploButton("Selection", style: .tertiary) {}
                            .hapticSelection()
                        
                        HaploButton("Success", style: .primary) {}
                            .hapticNotification(.success)
                        
                        HaploButton("Error", style: .destructive) {}
                            .hapticNotification(.error)
                    }
                }
                #endif
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(
            LinearGradient(
                colors: [
                    HaploTheme.Colors.primary.opacity(0.1),
                    HaploTheme.Colors.secondary.opacity(0.1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .confetti(isActive: $showConfetti)
        .navigationTitle("Effects")
    }
}

#Preview {
    NavigationStack {
        EffectsCatalog()
    }
}
