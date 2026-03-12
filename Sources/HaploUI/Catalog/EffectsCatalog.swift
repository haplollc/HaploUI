import SwiftUI

public struct EffectsCatalog: View {
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
                            .font(HaploTheme.Typography.headline)
                        Text("Content with a frosted glass effect background.")
                            .font(HaploTheme.Typography.body)
                            .foregroundColor(HaploTheme.Colors.secondaryLabel)
                    }
                    .padding(HaploTheme.Spacing.lg)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .glassCard()
                }
                
                CatalogSection("Shimmer Effect") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        Text("Loading content...")
                            .font(HaploTheme.Typography.headline)
                            .shimmer()
                        
                        HStack {
                            HaploSkeleton(width: 60, height: 60, cornerRadius: 30)
                            VStack(alignment: .leading, spacing: 8) {
                                HaploSkeleton(width: 150, height: 16)
                                HaploSkeleton(width: 100, height: 12)
                            }
                        }
                    }
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
        .navigationTitle("Effects")
    }
}

#Preview {
    NavigationStack {
        EffectsCatalog()
    }
}
