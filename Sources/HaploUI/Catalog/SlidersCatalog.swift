import SwiftUI

public struct SlidersCatalog: View {
    @State private var value1: Double = 50
    @State private var value2: Double = 25
    @State private var lowerValue: Double = 20
    @State private var upperValue: Double = 80
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Basic Slider") {
                        Text("Simple single-value selection")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploSlider(value: $value1, in: 0...100, label: "Volume")
                    }
                    
                    CatalogSection("With Step") {
                        Text("Discrete increments for precise control")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploSlider(
                            value: $value2,
                            in: 0...100,
                            step: 5,
                            label: "Brightness",
                            valueFormatter: { "\(Int($0))%" }
                        )
                    }
                    
                    CatalogSection("Custom Colors") {
                        Text("Match your app's color scheme")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 16) {
                            HaploSlider(
                                value: $value1,
                                in: 0...100,
                                label: "Progress",
                                accentColor: HaploTheme.Colors.success
                            )
                            
                            HaploSlider(
                                value: $value2,
                                in: 0...100,
                                label: "Warning Level",
                                accentColor: HaploTheme.Colors.warning
                            )
                        }
                    }
                    
                    CatalogSection("Range Slider") {
                        Text("Select a range with two handles")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploRangeSlider(
                            lowerValue: $lowerValue,
                            upperValue: $upperValue,
                            in: 0...100,
                            label: "Price Range",
                            valueFormatter: { "$\(Int($0)) - $\(Int($1))" }
                        )
                    }
                    
                    CatalogSection("Without Label") {
                        Text("Minimal style for inline use")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploSlider(value: $value1, in: 0...100)
                    }
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Sliders")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
    }
}

#Preview {
    NavigationStack {
        SlidersCatalog()
    }
}
