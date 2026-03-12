import SwiftUI

// MARK: - Text Field

public struct HaploTextField: View {
    @Binding var text: String
    let placeholder: String
    let label: String?
    let icon: String?
    let isSecure: Bool
    let errorMessage: String?
    let onSubmit: (() -> Void)?
    
    @FocusState private var isFocused: Bool
    
    public init(
        text: Binding<String>,
        placeholder: String,
        label: String? = nil,
        icon: String? = nil,
        isSecure: Bool = false,
        errorMessage: String? = nil,
        onSubmit: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.label = label
        self.icon = icon
        self.isSecure = isSecure
        self.errorMessage = errorMessage
        self.onSubmit = onSubmit
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: HaploTheme.Spacing.xs) {
            if let label = label {
                Text(label)
                    .font(HaploTheme.Typography.subheadline)
                    .foregroundColor(HaploTheme.Colors.secondaryLabel)
            }
            
            HStack(spacing: HaploTheme.Spacing.sm) {
                if let icon = icon {
                    Image(systemName: icon)
                        .foregroundColor(HaploTheme.Colors.secondaryLabel)
                        .font(.system(size: 16))
                }
                
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .focused($isFocused)
                        .onSubmit { onSubmit?() }
                } else {
                    TextField(placeholder, text: $text)
                        .focused($isFocused)
                        .onSubmit { onSubmit?() }
                }
                
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

// MARK: - Text Area

public struct HaploTextArea: View {
    @Binding var text: String
    let placeholder: String
    let label: String?
    let minHeight: CGFloat
    let maxHeight: CGFloat
    
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
            if let label = label {
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

public struct HaploSearchField: View {
    @Binding var text: String
    let placeholder: String
    let onSubmit: (() -> Void)?
    
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

public struct HaploToggle: View {
    @Binding var isOn: Bool
    let label: String
    let subtitle: String?
    let icon: String?
    
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
        Toggle(isOn: $isOn) {
            HStack(spacing: HaploTheme.Spacing.md) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(HaploTheme.Colors.primary)
                        .frame(width: 28)
                }
                
                VStack(alignment: .leading, spacing: HaploTheme.Spacing.xxs) {
                    Text(label)
                        .font(HaploTheme.Typography.body)
                        .foregroundColor(HaploTheme.Colors.label)
                    
                    if let subtitle = subtitle {
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
