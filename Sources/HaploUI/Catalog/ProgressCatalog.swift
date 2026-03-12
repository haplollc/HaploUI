import SwiftUI

public struct ProgressCatalog: View {
    @State private var progress: Double = 0.65
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Radial Progress") {
                    HStack(spacing: HaploTheme.Spacing.xl) {
                        HaploRadialProgress(progress: 0.3, size: 60)
                        HaploRadialProgress(progress: 0.65, size: 80)
                        HaploRadialProgress(progress: 0.9, size: 100)
                    }
                }
                
                CatalogSection("With Steps") {
                    HStack(spacing: HaploTheme.Spacing.xl) {
                        HaploRadialProgress(
                            progress: 0.3,
                            currentStep: 3,
                            totalSteps: 10,
                            size: 80
                        )
                        HaploRadialProgress(
                            progress: 0.7,
                            currentStep: 7,
                            totalSteps: 10,
                            size: 80,
                            accentColor: HaploTheme.Colors.success
                        )
                    }
                }
                
                CatalogSection("Linear Progress") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploLinearProgress(progress: 0.3)
                        HaploLinearProgress(progress: 0.65, accentColor: HaploTheme.Colors.success)
                        HaploLinearProgress(progress: 0.9, accentColor: HaploTheme.Colors.warning, showLabel: true)
                    }
                }
                
                CatalogSection("Interactive") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploLinearProgress(progress: progress, showLabel: true)
                        
                        Slider(value: $progress, in: 0...1)
                    }
                }
                
                CatalogSection("Indeterminate") {
                    HaploIndeterminateProgress()
                }
                
                CatalogSection("Loading Indicators") {
                    HStack(spacing: HaploTheme.Spacing.xxl) {
                        VStack {
                            HaploPulsingIndicator()
                            Text("Pulsing")
                                .font(HaploTheme.Typography.caption)
                        }
                        
                        VStack {
                            HaploDotsLoading()
                            Text("Dots")
                                .font(HaploTheme.Typography.caption)
                        }
                        
                        VStack {
                            ProgressView()
                            Text("System")
                                .font(HaploTheme.Typography.caption)
                        }
                    }
                    .foregroundColor(HaploTheme.Colors.secondaryLabel)
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
        .navigationTitle("Progress")
    }
}

#Preview {
    NavigationStack {
        ProgressCatalog()
    }
}
