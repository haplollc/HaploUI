//
//  HaploTextField.swift
//  HaploUI
//
//  Text input components from Haplo production apps (Chalk, Barrier).
//

import SwiftUI

// MARK: - Haplo Text Field (Rounded Input)

/// A rounded text field matching Chalk's GenerateWorkoutWidget input pattern.
public struct HaploTextField: View {
    @Binding var text: String
    var placeholder: String
    var placeholders: [String]  // Rotating placeholders
    var optionalLabel: String?
    
    @FocusState private var isFocused: Bool
    @State private var currentPlaceholderIndex: Int = 0
    @State private var placeholderTimer: Timer?
    
    public init(
        text: Binding<String>,
        placeholder: String = "",
        placeholders: [String] = [],
        optionalLabel: String? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.placeholders = placeholders
        self.optionalLabel = optionalLabel
    }
    
    private var currentPlaceholder: String {
        if !placeholders.isEmpty {
            return placeholders[currentPlaceholderIndex % placeholders.count]
        }
        return placeholder
    }
    
    public var body: some View {
        ZStack(alignment: text.contains(where: \.isNewline) ? .topLeading : .leading) {
            if text.isEmpty {
                HStack {
                    Text(currentPlaceholder)
                        .foregroundColor(.secondary.opacity(0.5))
                    Spacer()
                    if let label = optionalLabel {
                        Text(label)
                            .foregroundColor(.secondary.opacity(0.35))
                    }
                }
                .font(.system(size: 14))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .allowsHitTesting(false)
            }
            
            TextField("", text: $text, axis: .vertical)
                .textFieldStyle(.plain)
                .font(.system(size: 14))
                .lineLimit(1...5)
                .focused($isFocused)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
        }
        .background(HaploTheme.Colors.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(isFocused ? HaploTheme.Colors.primary.opacity(0.5) : Color.primary.opacity(0.15), lineWidth: 1)
        )
        .onAppear {
            if !placeholders.isEmpty {
                startPlaceholderRotation()
            }
        }
        .onDisappear {
            placeholderTimer?.invalidate()
        }
    }
    
    private func startPlaceholderRotation() {
        placeholderTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.3)) {
                currentPlaceholderIndex += 1
            }
        }
    }
}

// MARK: - Labeled Text Field

/// A text field with a label above it.
public struct HaploLabeledTextField: View {
    @Binding var text: String
    let label: String
    var placeholder: String
    var icon: String?
    var errorMessage: String?
    var onSubmit: (() -> Void)?
    
    @FocusState private var isFocused: Bool
    
    public init(
        text: Binding<String>,
        label: String,
        placeholder: String = "",
        icon: String? = nil,
        errorMessage: String? = nil,
        onSubmit: (() -> Void)? = nil
    ) {
        self._text = text
        self.label = label
        self.placeholder = placeholder
        self.icon = icon
        self.errorMessage = errorMessage
        self.onSubmit = onSubmit
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: HaploTheme.Spacing.xs) {
            Text(label)
                .font(HaploTheme.Typography.subheadline)
                .foregroundColor(HaploTheme.Colors.secondaryLabel)
            
            HStack(spacing: HaploTheme.Spacing.sm) {
                if let icon {
                    Image(systemName: icon)
                        .foregroundColor(HaploTheme.Colors.secondaryLabel)
                        .font(.system(size: 16))
                }
                
                TextField(placeholder, text: $text)
                    .focused($isFocused)
                    .onSubmit { onSubmit?() }
                
                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(HaploTheme.Colors.tertiaryLabel)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.horizontal, HaploTheme.Spacing.md)
            .padding(.vertical, HaploTheme.Spacing.md)
            .background(HaploTheme.Colors.secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md))
            .overlay(
                RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md)
                    .stroke(borderColor, lineWidth: 1.5)
            )
            
            if let error = errorMessage {
                Text(error)
                    .font(HaploTheme.Typography.caption)
                    .foregroundColor(HaploTheme.Colors.error)
            }
        }
    }
    
    private var borderColor: Color {
        if errorMessage != nil {
            return HaploTheme.Colors.error
        }
        return isFocused ? HaploTheme.Colors.primary : .clear
    }
}

// MARK: - Secure Field

/// A secure password field.
public struct HaploSecureField: View {
    @Binding var text: String
    let label: String
    var placeholder: String
    var errorMessage: String?
    var onSubmit: (() -> Void)?
    
    @FocusState private var isFocused: Bool
    @State private var isVisible: Bool = false
    
    public init(
        text: Binding<String>,
        label: String,
        placeholder: String = "Enter password",
        errorMessage: String? = nil,
        onSubmit: (() -> Void)? = nil
    ) {
        self._text = text
        self.label = label
        self.placeholder = placeholder
        self.errorMessage = errorMessage
        self.onSubmit = onSubmit
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: HaploTheme.Spacing.xs) {
            Text(label)
                .font(HaploTheme.Typography.subheadline)
                .foregroundColor(HaploTheme.Colors.secondaryLabel)
            
            HStack(spacing: HaploTheme.Spacing.sm) {
                Image(systemName: "lock")
                    .foregroundColor(HaploTheme.Colors.secondaryLabel)
                    .font(.system(size: 16))
                
                if isVisible {
                    TextField(placeholder, text: $text)
                        .focused($isFocused)
                        .onSubmit { onSubmit?() }
                } else {
                    SwiftUI.SecureField(placeholder, text: $text)
                        .focused($isFocused)
                        .onSubmit { onSubmit?() }
                }
                
                Button {
                    isVisible.toggle()
                } label: {
                    Image(systemName: isVisible ? "eye.slash" : "eye")
                        .foregroundColor(HaploTheme.Colors.tertiaryLabel)
                        .font(.system(size: 16))
                }
            }
            .padding(.horizontal, HaploTheme.Spacing.md)
            .padding(.vertical, HaploTheme.Spacing.md)
            .background(HaploTheme.Colors.secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md))
            .overlay(
                RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md)
                    .stroke(borderColor, lineWidth: 1.5)
            )
            
            if let error = errorMessage {
                Text(error)
                    .font(HaploTheme.Typography.caption)
                    .foregroundColor(HaploTheme.Colors.error)
            }
        }
    }
    
    private var borderColor: Color {
        if errorMessage != nil {
            return HaploTheme.Colors.error
        }
        return isFocused ? HaploTheme.Colors.primary : .clear
    }
}

// MARK: - Text Area

/// A multi-line text area.
public struct HaploTextArea: View {
    @Binding var text: String
    let placeholder: String
    var label: String?
    var minHeight: CGFloat
    var maxHeight: CGFloat
    
    public init(
        text: Binding<String>,
        placeholder: String,
        label: String? = nil,
        minHeight: CGFloat = 100,
        maxHeight: CGFloat = 200
    ) {
        self._text = text
        self.placeholder = placeholder
        self.label = label
        self.minHeight = minHeight
        self.maxHeight = maxHeight
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: HaploTheme.Spacing.xs) {
            if let label {
                Text(label)
                    .font(HaploTheme.Typography.subheadline)
                    .foregroundColor(HaploTheme.Colors.secondaryLabel)
            }
            
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .font(HaploTheme.Typography.body)
                        .foregroundColor(HaploTheme.Colors.tertiaryLabel)
                        .padding(.horizontal, HaploTheme.Spacing.md)
                        .padding(.vertical, HaploTheme.Spacing.md)
                }
                
                TextEditor(text: $text)
                    .font(HaploTheme.Typography.body)
                    .padding(.horizontal, HaploTheme.Spacing.sm)
                    .padding(.vertical, HaploTheme.Spacing.sm)
                    .frame(minHeight: minHeight, maxHeight: maxHeight)
                    .scrollContentBackground(.hidden)
            }
            .background(HaploTheme.Colors.secondaryBackground)
            .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.md))
        }
    }
}

// MARK: - Search Field

/// A capsule-shaped search field.
public struct HaploSearchField: View {
    @Binding var text: String
    var placeholder: String
    var onSubmit: (() -> Void)?
    
    @FocusState private var isFocused: Bool
    
    public init(
        text: Binding<String>,
        placeholder: String = "Search",
        onSubmit: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.onSubmit = onSubmit
    }
    
    public var body: some View {
        HStack(spacing: HaploTheme.Spacing.sm) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(HaploTheme.Colors.secondaryLabel)
                .font(.system(size: 16))
            
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .onSubmit { onSubmit?() }
            
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(HaploTheme.Colors.tertiaryLabel)
                        .font(.system(size: 16))
                }
            }
        }
        .padding(.horizontal, HaploTheme.Spacing.md)
        .padding(.vertical, HaploTheme.Spacing.sm)
        .background(HaploTheme.Colors.secondaryBackground)
        .clipShape(Capsule())
    }
}

// MARK: - Toggle

/// A toggle switch with optional icon and subtitle.
public struct HaploToggle: View {
    @Binding var isOn: Bool
    let label: String
    var subtitle: String?
    var icon: String?
    
    public init(
        isOn: Binding<Bool>,
        label: String,
        subtitle: String? = nil,
        icon: String? = nil
    ) {
        self._isOn = isOn
        self.label = label
        self.subtitle = subtitle
        self.icon = icon
    }
    
    public var body: some View {
        SwiftUI.Toggle(isOn: $isOn) {
            HStack(spacing: HaploTheme.Spacing.md) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(HaploTheme.Colors.primary)
                        .frame(width: 28)
                }
                
                VStack(alignment: .leading, spacing: HaploTheme.Spacing.xxs) {
                    Text(label)
                        .font(HaploTheme.Typography.body)
                        .foregroundColor(HaploTheme.Colors.label)
                    
                    if let subtitle {
                        Text(subtitle)
                            .font(HaploTheme.Typography.caption)
                            .foregroundColor(HaploTheme.Colors.secondaryLabel)
                    }
                }
            }
        }
        .tint(HaploTheme.Colors.primary)
    }
}
