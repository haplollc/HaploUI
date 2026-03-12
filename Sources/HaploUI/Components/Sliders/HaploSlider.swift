import SwiftUI

// MARK: - Haplo Slider

public struct HaploSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double?
    let label: String?
    let showValue: Bool
    let valueFormatter: (Double) -> String
    let trackColor: Color
    let accentColor: Color
    
    public init(
        value: Binding<Double>,
        in range: ClosedRange<Double>,
        step: Double? = nil,
        label: String? = nil,
        showValue: Bool = true,
        valueFormatter: @escaping (Double) -> String = { String(format: "%.0f", $0) },
        trackColor: Color = HaploTheme.Colors.secondaryBackground,
        accentColor: Color = HaploTheme.Colors.primary
    ) {
        self._value = value
        self.range = range
        self.step = step
        self.label = label
        self.showValue = showValue
        self.valueFormatter = valueFormatter
        self.trackColor = trackColor
        self.accentColor = accentColor
    }
    
    public var body: some View {
        VStack(spacing: HaploTheme.Spacing.sm) {
            if label != nil || showValue {
                HStack {
                    if let label = label {
                        Text(label)
                            .font(HaploTheme.Typography.subheadline)
                            .foregroundColor(HaploTheme.Colors.label)
                    }
                    Spacer()
                    if showValue {
                        Text(valueFormatter(value))
                            .font(HaploTheme.Typography.subheadline)
                            .foregroundColor(HaploTheme.Colors.secondaryLabel)
                            .monospacedDigit()
                    }
                }
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Track
                    RoundedRectangle(cornerRadius: 4)
                        .fill(trackColor)
                        .frame(height: 8)
                    
                    // Fill
                    RoundedRectangle(cornerRadius: 4)
                        .fill(accentColor)
                        .frame(width: fillWidth(for: geometry.size.width), height: 8)
                    
                    // Thumb
                    Circle()
                        .fill(.white)
                        .frame(width: 24, height: 24)
                        .haploShadow(HaploTheme.Shadows.md)
                        .offset(x: thumbOffset(for: geometry.size.width))
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { gesture in
                                    updateValue(for: gesture.location.x, width: geometry.size.width)
                                }
                        )
                }
                .frame(height: 24)
            }
            .frame(height: 24)
        }
    }
    
    private func fillWidth(for totalWidth: CGFloat) -> CGFloat {
        let percentage = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        return totalWidth * CGFloat(percentage)
    }
    
    private func thumbOffset(for totalWidth: CGFloat) -> CGFloat {
        let percentage = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        return (totalWidth - 24) * CGFloat(percentage)
    }
    
    private func updateValue(for x: CGFloat, width: CGFloat) {
        let percentage = max(0, min(1, x / width))
        var newValue = range.lowerBound + Double(percentage) * (range.upperBound - range.lowerBound)
        
        if let step = step {
            newValue = round(newValue / step) * step
        }
        
        value = max(range.lowerBound, min(range.upperBound, newValue))
    }
}

// MARK: - Range Slider

public struct HaploRangeSlider: View {
    @Binding var lowerValue: Double
    @Binding var upperValue: Double
    let range: ClosedRange<Double>
    let label: String?
    let valueFormatter: (Double, Double) -> String
    let accentColor: Color
    
    public init(
        lowerValue: Binding<Double>,
        upperValue: Binding<Double>,
        in range: ClosedRange<Double>,
        label: String? = nil,
        valueFormatter: @escaping (Double, Double) -> String = { "\(Int($0)) - \(Int($1))" },
        accentColor: Color = HaploTheme.Colors.primary
    ) {
        self._lowerValue = lowerValue
        self._upperValue = upperValue
        self.range = range
        self.label = label
        self.valueFormatter = valueFormatter
        self.accentColor = accentColor
    }
    
    public var body: some View {
        VStack(spacing: HaploTheme.Spacing.sm) {
            HStack {
                if let label = label {
                    Text(label)
                        .font(HaploTheme.Typography.subheadline)
                        .foregroundColor(HaploTheme.Colors.label)
                }
                Spacer()
                Text(valueFormatter(lowerValue, upperValue))
                    .font(HaploTheme.Typography.subheadline)
                    .foregroundColor(HaploTheme.Colors.secondaryLabel)
                    .monospacedDigit()
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Track
                    RoundedRectangle(cornerRadius: 4)
                        .fill(HaploTheme.Colors.secondaryBackground)
                        .frame(height: 8)
                    
                    // Fill between thumbs
                    RoundedRectangle(cornerRadius: 4)
                        .fill(accentColor)
                        .frame(width: fillWidth(for: geometry.size.width), height: 8)
                        .offset(x: lowerThumbOffset(for: geometry.size.width) + 12)
                    
                    // Lower thumb
                    Circle()
                        .fill(.white)
                        .frame(width: 24, height: 24)
                        .haploShadow(HaploTheme.Shadows.md)
                        .offset(x: lowerThumbOffset(for: geometry.size.width))
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { gesture in
                                    updateLowerValue(for: gesture.location.x, width: geometry.size.width)
                                }
                        )
                    
                    // Upper thumb
                    Circle()
                        .fill(.white)
                        .frame(width: 24, height: 24)
                        .haploShadow(HaploTheme.Shadows.md)
                        .offset(x: upperThumbOffset(for: geometry.size.width))
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { gesture in
                                    updateUpperValue(for: gesture.location.x, width: geometry.size.width)
                                }
                        )
                }
                .frame(height: 24)
            }
            .frame(height: 24)
        }
    }
    
    private func lowerThumbOffset(for width: CGFloat) -> CGFloat {
        let percentage = (lowerValue - range.lowerBound) / (range.upperBound - range.lowerBound)
        return (width - 24) * CGFloat(percentage)
    }
    
    private func upperThumbOffset(for width: CGFloat) -> CGFloat {
        let percentage = (upperValue - range.lowerBound) / (range.upperBound - range.lowerBound)
        return (width - 24) * CGFloat(percentage)
    }
    
    private func fillWidth(for width: CGFloat) -> CGFloat {
        let lowerPercentage = (lowerValue - range.lowerBound) / (range.upperBound - range.lowerBound)
        let upperPercentage = (upperValue - range.lowerBound) / (range.upperBound - range.lowerBound)
        return (width - 24) * CGFloat(upperPercentage - lowerPercentage)
    }
    
    private func updateLowerValue(for x: CGFloat, width: CGFloat) {
        let percentage = max(0, min(1, x / width))
        let newValue = range.lowerBound + Double(percentage) * (range.upperBound - range.lowerBound)
        lowerValue = max(range.lowerBound, min(upperValue - 1, newValue))
    }
    
    private func updateUpperValue(for x: CGFloat, width: CGFloat) {
        let percentage = max(0, min(1, x / width))
        let newValue = range.lowerBound + Double(percentage) * (range.upperBound - range.lowerBound)
        upperValue = max(lowerValue + 1, min(range.upperBound, newValue))
    }
}
