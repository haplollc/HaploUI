import SwiftUI

public struct SlidersCatalog: View {
    @State private var value1: Double = 50
    @State private var value2: Double = 25
    @State private var lowerValue: Double = 20
    @State private var upperValue: Double = 80
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Basic Slider") {
                    HaploSlider(value: $value1, in: 0...100, label: "Volume")
                }
                
                CatalogSection("With Step") {
                    HaploSlider(
                        value: $value2,
                        in: 0...100,
                        step: 5,
                        label: "Brightness",
                        valueFormatter: { "\(Int($0))%" }
                    )
                }
                
                CatalogSection("Custom Colors") {
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
                
                CatalogSection("Range Slider") {
                    HaploRangeSlider(
                        lowerValue: $lowerValue,
                        upperValue: $upperValue,
                        in: 0...100,
                        label: "Price Range",
                        valueFormatter: { "$\(Int($0)) - $\(Int($1))" }
                    )
                }
                
                CatalogSection("Without Label") {
                    HaploSlider(value: $value1, in: 0...100)
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
        .navigationTitle("Sliders")
    }
}

#Preview {
    NavigationStack {
        SlidersCatalog()
    }
}
