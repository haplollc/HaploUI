//
//  HaploSegmentedControl.swift
//  HaploUI
//
//  Segmented control from Chalk's CustomSegmentedControl.
//

import SwiftUI

// MARK: - Segmented Control

public struct HaploSegmentedControl<T: Hashable>: View {
    let options: [T]
    let optionLabels: (T) -> String
    @Binding var selection: T
    
    @Namespace private var animation
    
    public init(
        options: [T],
        selection: Binding<T>,
        optionLabels: @escaping (T) -> String
    ) {
        self.options = options
        self._selection = selection
        self.optionLabels = optionLabels
    }
    
    public var body: some View {
        segmentedContent
            .padding(4)
            .background(outlineBackground)
            .clipShape(Capsule())
    }
    
    private var segmentedContent: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                segmentButton(for: option)
            }
        }
    }
    
    private func segmentButton(for option: T) -> some View {
        let isSelected = selection == option
        
        return Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selection = option
            }
        }) {
            segmentLabel(for: option, isSelected: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
        #if os(iOS)
        .haptic(.selection)
        #endif
    }
    
    private func segmentLabel(for option: T, isSelected: Bool) -> some View {
        Text(optionLabels(option))
            .font(.system(size: 15, weight: isSelected ? .semibold : .regular, design: .rounded))
            .foregroundColor(isSelected ? HaploTheme.Colors.background : HaploTheme.Colors.label)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(segmentBackground(isSelected: isSelected))
    }
    
    @ViewBuilder
    private func segmentBackground(isSelected: Bool) -> some View {
        if isSelected {
            Capsule()
                .fill(HaploTheme.Colors.label)
                .matchedGeometryEffect(id: "pill", in: animation)
        }
    }
    
    private var outlineBackground: some View {
        Capsule()
            .strokeBorder(HaploTheme.Colors.label.opacity(0.2), lineWidth: 1)
    }
}

// MARK: - Convenience Initializers

public extension HaploSegmentedControl where T: RawRepresentable, T.RawValue == String {
    init(options: [T], selection: Binding<T>) {
        self.init(options: options, selection: selection) { $0.rawValue }
    }
}

public extension HaploSegmentedControl where T == String {
    init(options: [String], selection: Binding<String>) {
        self.init(options: options, selection: selection) { $0 }
    }
}

public extension HaploSegmentedControl where T == Int {
    init(options: [Int], labels: [String], selection: Binding<Int>) {
        self.init(options: options, selection: selection) { labels[options.firstIndex(of: $0) ?? 0] }
    }
}

// MARK: - Icon Segmented Control

/// A segmented control with icons instead of text.
public struct HaploIconSegmentedControl<T: Hashable>: View {
    let options: [T]
    let optionIcons: (T) -> String
    @Binding var selection: T
    
    @Namespace private var animation
    
    public init(
        options: [T],
        selection: Binding<T>,
        optionIcons: @escaping (T) -> String
    ) {
        self.options = options
        self._selection = selection
        self.optionIcons = optionIcons
    }
    
    public var body: some View {
        iconSegmentedContent
            .padding(4)
            .background(iconOutlineBackground)
            .clipShape(Capsule())
    }
    
    private var iconSegmentedContent: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                iconSegmentButton(for: option)
            }
        }
    }
    
    private func iconSegmentButton(for option: T) -> some View {
        let isSelected = selection == option
        
        return Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selection = option
            }
        }) {
            iconSegmentLabel(for: option, isSelected: isSelected)
        }
        .buttonStyle(PlainButtonStyle())
        #if os(iOS)
        .haptic(.selection)
        #endif
    }
    
    private func iconSegmentLabel(for option: T, isSelected: Bool) -> some View {
        Image(systemName: optionIcons(option))
            .font(.system(size: 16, weight: isSelected ? .semibold : .regular))
            .foregroundColor(isSelected ? HaploTheme.Colors.background : HaploTheme.Colors.label)
            .frame(width: 44, height: 32)
            .background(iconSegmentBackground(isSelected: isSelected))
    }
    
    @ViewBuilder
    private func iconSegmentBackground(isSelected: Bool) -> some View {
        if isSelected {
            Capsule()
                .fill(HaploTheme.Colors.label)
                .matchedGeometryEffect(id: "iconPill", in: animation)
        }
    }
    
    private var iconOutlineBackground: some View {
        Capsule()
            .strokeBorder(HaploTheme.Colors.label.opacity(0.2), lineWidth: 1)
    }
}
