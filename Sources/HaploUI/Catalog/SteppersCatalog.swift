import SwiftUI

public struct SteppersCatalog: View {
    @State private var value1 = 5
    @State private var value2 = 10
    @State private var value3 = 25
    @State private var borderedValue = 3
    @State private var borderedText = "3 hours"
    
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
                
                CatalogSection("Bordered Stepper (from Barrier)") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploBorderedStepper(
                            value: $borderedValue,
                            displayText: $borderedText,
                            accessibilityLabelPrefix: "Duration",
                            stepperColor: .accentColor,
                            textColor: .text1
                        )
                        .onChange(of: borderedValue) { _, newValue in
                            borderedText = "\(newValue) hours"
                        }
                        
                        Text("Features: Haptic feedback, accessibility, Dynamic Type scaling")
                            .font(.haploCaption())
                            .foregroundColor(.text3)
                    }
                }
                
                CatalogSection("Bordered Stepper Variants") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploBorderedStepper(
                            value: .constant(5),
                            displayText: .constant("5 items"),
                            stepperColor: .green
                        )
                        
                        HaploBorderedStepper(
                            value: .constant(2),
                            displayText: .constant("2 sessions"),
                            stepperColor: .purple
                        )
                        
                        HaploBorderedStepper(
                            value: .constant(10),
                            displayText: .constant("10 min"),
                            stepperColor: .orange
                        )
                    }
                }
                
                CatalogSection("Compact Stepper") {
                    HStack {
                        Text("Sets")
                            .font(.haploBody())
                        Spacer()
                        HaploCompactStepper(value: $value1, in: 1...20)
                    }
                }
                
                CatalogSection("Compact Stepper Colors") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HStack {
                            Text("Default")
                                .font(.haploBody())
                            Spacer()
                            HaploCompactStepper(value: $value1, in: 1...20)
                        }
                        
                        HStack {
                            Text("Green")
                                .font(.haploBody())
                            Spacer()
                            HaploCompactStepper(value: $value2, in: 1...20, color: .green)
                        }
                        
                        HStack {
                            Text("Orange")
                                .font(.haploBody())
                            Spacer()
                            HaploCompactStepper(value: $value3, in: 1...100, step: 5, color: .orange)
                        }
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
        .background(Color.background1)
        .navigationTitle("Steppers")
    }
}

#Preview {
    NavigationStack {
        SteppersCatalog()
    }
}
