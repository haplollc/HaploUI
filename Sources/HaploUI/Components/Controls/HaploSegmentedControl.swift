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
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selection = option
                    }
                } label: {
                    Text(optionLabels(option))
                        .font(.system(size: 15, weight: selection == option ? .semibold : .regular, design: .rounded))
                        .foregroundColor(selection == option ? HaploTheme.Colors.background : HaploTheme.Colors.label)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            ZStack {
                                if selection == option {
                                    Capsule()
                                        .fill(HaploTheme.Colors.label)
                                        .matchedGeometryEffect(id: "pill", in: animation)
                                }
                            }
                        )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(4)
        .background(
            Capsule()
                .strokeBorder(HaploTheme.Colors.label.opacity(0.2), lineWidth: 1)
        )
        .clipShape(Capsule())
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
