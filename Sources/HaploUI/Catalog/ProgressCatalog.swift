import SwiftUI

public struct ProgressCatalog: View {
    @State private var progress: Double = 0.65
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Radial Progress") {
                        Text("Circular progress indicators")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 24) {
                            VStack(spacing: 8) {
                                HaploRadialProgress(progress: 0.3, size: 60)
                                Text("30%")
                                    .font(.haploCaption())
                                    .foregroundStyle(Color.text3)
                            }
                            VStack(spacing: 8) {
                                HaploRadialProgress(progress: 0.65, size: 80)
                                Text("65%")
                                    .font(.haploCaption())
                                    .foregroundStyle(Color.text3)
                            }
                            VStack(spacing: 8) {
                                HaploRadialProgress(progress: 0.9, size: 100)
                                Text("90%")
                                    .font(.haploCaption())
                                    .foregroundStyle(Color.text3)
                            }
                            Spacer()
                        }
                    }
                    
                    CatalogSection("With Steps") {
                        Text("Show progress as discrete steps")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 24) {
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
                            Spacer()
                        }
                    }
                    
                    CatalogSection("Linear Progress") {
                        Text("Horizontal progress bars")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Default")
                                    .font(.haploCaption())
                                    .foregroundStyle(Color.text3)
                                HaploLinearProgress(progress: 0.3)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Success")
                                    .font(.haploCaption())
                                    .foregroundStyle(Color.text3)
                                HaploLinearProgress(progress: 0.65, accentColor: HaploTheme.Colors.success)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("With Label")
                                    .font(.haploCaption())
                                    .foregroundStyle(Color.text3)
                                HaploLinearProgress(progress: 0.9, accentColor: HaploTheme.Colors.warning, showLabel: true)
                            }
                        }
                    }
                    
                    CatalogSection("Interactive") {
                        Text("Adjust progress with slider")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 16) {
                            HaploLinearProgress(progress: progress, showLabel: true)
                            
                            Slider(value: $progress, in: 0...1)
                                .tint(.accentColor)
                        }
                    }
                    
                    CatalogSection("Indeterminate") {
                        Text("Unknown duration loading state")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploIndeterminateProgress()
                    }
                    
                    CatalogSection("Loading Indicators") {
                        Text("Different loading animation styles")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 32) {
                            VStack(spacing: 12) {
                                HaploPulsingIndicator()
                                Text("Pulsing")
                                    .font(.haploCaption())
                                    .foregroundStyle(Color.text3)
                            }
                            
                            VStack(spacing: 12) {
                                HaploDotsLoading()
                                Text("Dots")
                                    .font(.haploCaption())
                                    .foregroundStyle(Color.text3)
                            }
                            
                            VStack(spacing: 12) {
                                ProgressView()
                                Text("System")
                                    .font(.haploCaption())
                                    .foregroundStyle(Color.text3)
                            }
                            
                            Spacer()
                        }
                    }
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Progress")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
    }
}

#Preview {
    NavigationStack {
        ProgressCatalog()
    }
}
