//
//  HaploStepper.swift
//  HaploUI
//
//  Stepper components extracted from Haplo production apps.
//  Original source: barrier_swiftui (CustomStepper)
//

import SwiftUI
#if os(iOS)
import UIKit
#endif

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
                    .font(.haploBody())
                    .foregroundColor(.text1)
                Spacer()
            }
            
            HStack(spacing: 0) {
                // Decrement
                Button {
                    if value > range.lowerBound {
                        value = max(range.lowerBound, value - step)
                        triggerHaptic()
                    }
                } label: {
                    Image(systemName: "minus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(value > range.lowerBound ? HaploTheme.Colors.primary : .text3)
                        .frame(width: 44, height: 36)
                }
                .disabled(value <= range.lowerBound)
                
                // Value
                Text(valueFormatter(value))
                    .font(.haploHeadline())
                    .foregroundColor(.text1)
                    .frame(minWidth: 44)
                    .monospacedDigit()
                
                // Increment
                Button {
                    if value < range.upperBound {
                        value = min(range.upperBound, value + step)
                        triggerHaptic()
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(value < range.upperBound ? HaploTheme.Colors.primary : .text3)
                        .frame(width: 44, height: 36)
                }
                .disabled(value >= range.upperBound)
            }
            .background(Color.background2)
            .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md))
        }
    }
    
    private func triggerHaptic() {
        #if os(iOS)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        #endif
    }
}

// MARK: - Bordered Stepper (from Barrier's CustomStepper)

/// A stepper with +/- circle buttons and stroke border styling
/// Features haptic feedback, accessibility support, and Dynamic Type scaling
public struct HaploBorderedStepper: View {
    @Binding var value: Int
    @Binding var displayText: String
    
    /// Optional label for accessibility context
    var accessibilityLabelPrefix: String
    var stepperColor: Color
    var textColor: Color
    
    /// Scaled icon size for Dynamic Type support
    @ScaledMetric(relativeTo: .body) private var iconSize: CGFloat = 25

    public init(
        value: Binding<Int>,
        displayText: Binding<String>,
        accessibilityLabelPrefix: String = "Value",
        stepperColor: Color = .accentColor,
        textColor: Color = .text1
    ) {
        self._value = value
        self._displayText = displayText
        self.accessibilityLabelPrefix = accessibilityLabelPrefix
        self.stepperColor = stepperColor
        self.textColor = textColor
    }
    
    public var body: some View {
        HStack {
            Button(action: {
                if value > 0 {
                    value -= 1
                    triggerHaptic()
                    announceChange()
                }
            }) {
                Image(systemName: "minus.circle.fill")
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(stepperColor)
            }
            .accessibilityLabel("Decrease \(accessibilityLabelPrefix.lowercased())")
            .accessibilityHint("Current value is \(displayText). Double tap to decrease")

            Text(displayText)
                .font(.haploHeadline())
                .foregroundColor(textColor)
                .accessibilityHidden(true)

            Button(action: {
                value += 1
                triggerHaptic()
                announceChange()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(stepperColor)
            }
            .accessibilityLabel("Increase \(accessibilityLabelPrefix.lowercased())")
            .accessibilityHint("Current value is \(displayText). Double tap to increase")
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).stroke(stepperColor, lineWidth: 3))
        .accessibilityElement(children: .contain)
        .accessibilityLabel("\(accessibilityLabelPrefix): \(displayText)")
    }
    
    private func triggerHaptic() {
        #if os(iOS)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        #endif
    }
    
    private func announceChange() {
        #if os(iOS)
        UIAccessibility.post(notification: .announcement, argument: displayText)
        #endif
    }
}

// MARK: - Compact Stepper

public struct HaploCompactStepper: View {
    @Binding var value: Int
    let range: ClosedRange<Int>
    let step: Int
    var color: Color
    
    /// Scaled icon size for Dynamic Type support
    @ScaledMetric(relativeTo: .body) private var iconSize: CGFloat = 28
    
    public init(
        value: Binding<Int>,
        in range: ClosedRange<Int>,
        step: Int = 1,
        color: Color = .accentColor
    ) {
        self._value = value
        self.range = range
        self.step = step
        self.color = color
    }
    
    public var body: some View {
        HStack(spacing: HaploTheme.Spacing.xs) {
            Button {
                if value > range.lowerBound {
                    value = max(range.lowerBound, value - step)
                    triggerHaptic()
                }
            } label: {
                Image(systemName: "minus.circle.fill")
                    .font(.system(size: iconSize))
                    .foregroundColor(value > range.lowerBound ? color : .text3)
            }
            .disabled(value <= range.lowerBound)
            .accessibilityLabel("Decrease")
            .accessibilityHint("Current value is \(value)")
            
            Text("\(value)")
                .font(.haploTitle2())
                .foregroundColor(.text1)
                .frame(minWidth: 50)
                .monospacedDigit()
            
            Button {
                if value < range.upperBound {
                    value = min(range.upperBound, value + step)
                    triggerHaptic()
                }
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: iconSize))
                    .foregroundColor(value < range.upperBound ? color : .text3)
            }
            .disabled(value >= range.upperBound)
            .accessibilityLabel("Increase")
            .accessibilityHint("Current value is \(value)")
        }
        .accessibleTapTarget()
    }
    
    private func triggerHaptic() {
        #if os(iOS)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        #endif
    }
}

// MARK: - Wheel Stepper

#if os(iOS)
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
                    .font(.haploBody())
                    .foregroundColor(.text1)
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
#else
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
                    .font(.haploBody())
                    .foregroundColor(.text1)
                Spacer()
            }
            
            Picker("", selection: $value) {
                ForEach(range, id: \.self) { val in
                    Text("\(val)").tag(val)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 200)
        }
    }
}
#endif
