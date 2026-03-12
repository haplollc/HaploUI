import SwiftUI

public struct SteppersCatalog: View {
    @State private var value1 = 5
    @State private var value2 = 10
    @State private var value3 = 25
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Standard Stepper") {
                    HaploStepper(value: $value1, in: 0...10, label: "Quantity")
                }
                
                CatalogSection("With Custom Step") {
                    HaploStepper(
                        value: $value2,
                        in: 0...100,
                        step: 5,
                        label: "Minutes",
                        valueFormatter: { "\($0) min" }
                    )
                }
                
                CatalogSection("Compact Stepper") {
                    HStack {
                        Text("Sets")
                            .font(HaploTheme.Typography.body)
                        Spacer()
                        HaploCompactStepper(value: $value1, in: 1...20)
                    }
                }
                
                CatalogSection("Wheel Stepper") {
                    HaploWheelStepper(value: $value3, in: 1...60, label: "Timer")
                }
                
                CatalogSection("Multiple Steppers") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploStepper(value: $value1, in: 1...10, label: "Sets")
                        HaploStepper(value: $value2, in: 1...20, label: "Reps")
                        HaploStepper(
                            value: $value3,
                            in: 0...500,
                            step: 5,
                            label: "Weight (lbs)"
                        )
                    }
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
        .navigationTitle("Steppers")
    }
}

#Preview {
    NavigationStack {
        SteppersCatalog()
    }
}
