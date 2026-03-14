import SwiftUI

public struct EffectsCatalog: View {
    @State private var showConfetti = false
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [
                    Color.background1,
                    HaploTheme.Colors.primary.opacity(0.05),
                    HaploTheme.Colors.secondary.opacity(0.05)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Glass Capsule") {
                        Text("Frosted glass effect for tags and labels")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 12) {
                            Text("Default")
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .glassCapsule()
                            
                            Text("Tinted")
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .glassCapsule(tint: .blue)
                            
                            Spacer()
                        }
                    }
                    
                    CatalogSection("Glass Circle") {
                        Text("Circular glass containers for icons")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 16) {
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
                            
                            Image(systemName: "bolt.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .frame(width: 50, height: 50)
                                .glassCircle(tint: .blue)
                            
                            Spacer()
                        }
                    }
                    
                    CatalogSection("Glass Card") {
                        Text("Elegant frosted glass containers")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Glass Card")
                                .font(.haploHeadline(.bold))
                                .foregroundStyle(Color.text1)
                            Text("Content with a beautiful frosted glass effect background. Perfect for overlays and floating UI.")
                                .font(.haploBody())
                                .foregroundStyle(Color.text2)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .glassCard()
                    }
                    
                    CatalogSection("Shimmer View") {
                        Text("Loading placeholders from Chalk")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
                            HaploShimmerView()
                                .frame(height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            HaploShimmerText("Loading content...")
                                .font(.haploHeadline())
                            
                            HaploMapShimmer()
                                .frame(height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    
                    CatalogSection("Shimmer Text") {
                        Text("Animated gradient text effect")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Shimmer text effect")
                            .font(.haploTitle2(.bold))
                            .shimmer()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    CatalogSection("Skeleton Loading") {
                        Text("Content placeholders during data fetch")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            HaploSkeleton(height: 20)
                            HaploSkeleton(width: 200, height: 16)
                            HaploSkeleton(width: 150, height: 16)
                            
                            HStack(spacing: 12) {
                                HaploSkeleton(width: 80, height: 80, cornerRadius: 12)
                                VStack(alignment: .leading, spacing: 8) {
                                    HaploSkeleton(height: 18)
                                    HaploSkeleton(width: 120, height: 14)
                                }
                            }
                        }
                    }
                    
                    CatalogSection("Blink Effect") {
                        Text("Pulsing animation from Haplo Invest")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 16) {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.text3.opacity(0.3))
                                .frame(width: 60, height: 60)
                                .blinking(duration: 0.5)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Loading...")
                                    .font(.haploHeadline())
                                    .blinking()
                                Text("Please wait")
                                    .font(.haploCaption())
                                    .blinking(duration: 1.0)
                            }
                            
                            Spacer()
                        }
                    }
                    
                    CatalogSection("Card Style") {
                        Text("Elevated card with shadow from Chalk")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Card Title")
                                .font(.haploHeadline(.bold))
                                .foregroundStyle(Color.text1)
                            Text("Uses the cardStyle modifier for consistent elevation and shadows.")
                                .font(.haploBody())
                                .foregroundStyle(Color.text2)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .cardStyle()
                    }
                    
                    CatalogSection("Siri Orb") {
                        Text("Audio-reactive glass orb with Metal shader")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Spacer()
                            HaploSiriOrb.demo(size: 150)
                                .frame(height: 180)
                            Spacer()
                        }
                        
                        Text("Speak or make noise to see the orb react")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    CatalogSection("Confetti 🎉") {
                        Text("Celebration animation for achievements")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploPrimaryButton("Show Confetti", systemImage: "party.popper") {
                            showConfetti = true
                        }
                    }
                    
                    #if os(iOS)
                    CatalogSection("Haptic Feedback") {
                        Text("Tactile responses for user interactions")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            HaploCapsuleButton("Light") {}
                                .haptic(.light)
                            
                            HaploCapsuleButton("Medium") {}
                                .haptic(.medium)
                            
                            HaploCapsuleButton("Heavy") {}
                                .haptic(.heavy)
                            
                            HaploCapsuleButton("Selection") {}
                                .hapticSelection()
                            
                            HaploPrimaryButton("Success") {}
                                .hapticNotification(.success)
                            
                            HaploDestructiveButton("Error") {}
                                .hapticNotification(.error)
                        }
                    }
                    #endif
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .confetti(isActive: $showConfetti)
        .navigationTitle("Effects")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
    }
}

#Preview {
    NavigationStack {
        EffectsCatalog()
    }
}
