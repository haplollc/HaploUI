import SwiftUI

// MARK: - Haplo Stepper

public struct HaploStepper: View {
    @Binding var value: Int
    let range: ClosedRange<Int>
    let step: Int
    let label: String?
    let valueFormatter: (Int) -> String
    
    public init(
        value: Binding<Int>,
        in range: ClosedRange<Int>,
        step: Int = 1,
        label: String? = nil,
        valueFormatter: @escaping (Int) -> String = { "\($0)" }
    ) {
        self._value = value
        self.range = range
        self.step = step
        self.label = label
        self.valueFormatter = valueFormatter
    }
    
    public var body: some View {
        HStack {
            if let label = label {
                Text(label)
                    .font(HaploTheme.Typography.body)
                    .foregroundColor(HaploTheme.Colors.label)
                Spacer()
            }
            
            HStack(spacing: 0) {
                // Decrement
                Button {
                    if value > range.lowerBound {
                        value = max(range.lowerBound, value - step)
                    }
                } label: {
                    Image(systemName: "minus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(value > range.lowerBound ? HaploTheme.Colors.primary : HaploTheme.Colors.tertiaryLabel)
                        .frame(width: 44, height: 36)
                }
                .disabled(value <= range.lowerBound)
                
                // Value
                Text(valueFormatter(value))
                    .font(HaploTheme.Typography.headline)
                    .foregroundColor(HaploTheme.Colors.label)
                    .frame(minWidth: 44)
                    .monospacedDigit()
                
                // Increment
                Button {
                    if value < range.upperBound {
                        value = min(range.upperBound, value + step)
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(value < range.upperBound ? HaploTheme.Colors.primary : HaploTheme.Colors.tertiaryLabel)
                        .frame(width: 44, height: 36)
                }
                .disabled(value >= range.upperBound)
            }
            .background(HaploTheme.Colors.secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md))
        }
    }
}

// MARK: - Compact Stepper

public struct HaploCompactStepper: View {
    @Binding var value: Int
    let range: ClosedRange<Int>
    let step: Int
    
    public init(
        value: Binding<Int>,
        in range: ClosedRange<Int>,
        step: Int = 1
    ) {
        self._value = value
        self.range = range
        self.step = step
    }
    
    public var body: some View {
        HStack(spacing: HaploTheme.Spacing.xs) {
            Button {
                if value > range.lowerBound {
                    value = max(range.lowerBound, value - step)
                }
            } label: {
                Image(systemName: "minus.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(value > range.lowerBound ? HaploTheme.Colors.primary : HaploTheme.Colors.tertiaryLabel)
            }
            .disabled(value <= range.lowerBound)
            
            Text("\(value)")
                .font(HaploTheme.Typography.title2)
                .foregroundColor(HaploTheme.Colors.label)
                .frame(minWidth: 50)
                .monospacedDigit()
            
            Button {
                if value < range.upperBound {
                    value = min(range.upperBound, value + step)
                }
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(value < range.upperBound ? HaploTheme.Colors.primary : HaploTheme.Colors.tertiaryLabel)
            }
            .disabled(value >= range.upperBound)
        }
    }
}

// MARK: - Wheel Stepper

public struct HaploWheelStepper: View {
    @Binding var value: Int
    let range: ClosedRange<Int>
    let label: String?
    
    public init(
        value: Binding<Int>,
        in range: ClosedRange<Int>,
        label: String? = nil
    ) {
        self._value = value
        self.range = range
        self.label = label
    }
    
    public var body: some View {
        HStack {
            if let label = label {
                Text(label)
                    .font(HaploTheme.Typography.body)
                    .foregroundColor(HaploTheme.Colors.label)
                Spacer()
            }
            
            Picker("", selection: $value) {
                ForEach(range, id: \.self) { val in
                    Text("\(val)").tag(val)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 100, height: 100)
            .clipped()
        }
    }
}
