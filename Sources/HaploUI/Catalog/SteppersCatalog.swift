import SwiftUI

public struct SteppersCatalog: View {
    @State private var value1 = 5
    @State private var value2 = 10
    @State private var value3 = 25
    @State private var borderedValue = 3
    @State private var borderedText = "3 hours"
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Standard Stepper") {
                        Text("Basic increment/decrement control")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploStepper(value: $value1, in: 0...10, label: "Quantity")
                    }
                    
                    CatalogSection("With Custom Step") {
                        Text("Jump by custom increments")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploStepper(
                            value: $value2,
                            in: 0...100,
                            step: 5,
                            label: "Minutes",
                            valueFormatter: { "\($0) min" }
                        )
                    }
                    
                    CatalogSection("Bordered Stepper") {
                        Text("From Barrier - with haptics & accessibility")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
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
                        }
                    }
                    
                    CatalogSection("Bordered Variants") {
                        Text("Color customization options")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
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
                        Text("Minimal inline stepper")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("Sets")
                                    .font(.haploBody())
                                    .foregroundStyle(Color.text1)
                                Spacer()
                                HaploCompactStepper(value: $value1, in: 1...20)
                            }
                            
                            HStack {
                                Text("Reps")
                                    .font(.haploBody())
                                    .foregroundStyle(Color.text1)
                                Spacer()
                                HaploCompactStepper(value: $value2, in: 1...20, color: .green)
                            }
                            
                            HStack {
                                Text("Weight")
                                    .font(.haploBody())
                                    .foregroundStyle(Color.text1)
                                Spacer()
                                HaploCompactStepper(value: $value3, in: 1...100, step: 5, color: .orange)
                            }
                        }
                    }
                    
                    CatalogSection("Wheel Stepper") {
                        Text("Picker-style selection")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploWheelStepper(value: $value3, in: 1...60, label: "Timer")
                    }
                    
                    CatalogSection("Exercise Set") {
                        Text("Real-world usage example")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
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
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Steppers")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
    }
}

#Preview {
    NavigationStack {
        SteppersCatalog()
    }
}
