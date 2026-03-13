//
//  HaploChatInputBar.swift
//  HaploUI
//
//  Chat input bar component extracted from Haplo production apps.
//  Original source: HaploAI
//

import SwiftUI
#if os(iOS)
import UIKit
#endif

// MARK: - Chat Input Bar

public struct HaploChatInputBar: View {
    @Binding var text: String
    var placeholder: String
    var isGenerating: Bool
    var onSend: () -> Void
    var onStop: (() -> Void)?
    
    @FocusState private var isFocused: Bool
    
    public init(
        text: Binding<String>,
        placeholder: String = "Message",
        isGenerating: Bool = false,
        onSend: @escaping () -> Void,
        onStop: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.isGenerating = isGenerating
        self.onSend = onSend
        self.onStop = onStop
    }
    
    private var canSend: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isGenerating
    }
    
    public var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            textInputArea
            sendButton
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(inputBackground)
    }
    
    @ViewBuilder
    private var textInputArea: some View {
        TextField(placeholder, text: $text, axis: .vertical)
            .textFieldStyle(.plain)
            .font(.haploBody())
            .lineLimit(1...6)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(textFieldBackground)
            .focused($isFocused)
            .disabled(isGenerating)
            .opacity(isGenerating ? 0.7 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isGenerating)
    }
    
    @ViewBuilder
    private var sendButton: some View {
        Button(action: sendButtonAction) {
            Group {
                if isGenerating {
                    Image(systemName: "stop.fill")
                } else {
                    Image(systemName: "paperplane.fill")
                }
            }
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(sendButtonDisabled ? .text3 : .text1)
        }
        .frame(width: 44, height: 44)
        .background(sendButtonBackground)
        .clipShape(Circle())
        .disabled(sendButtonDisabled && !isGenerating)
        .animation(.easeInOut(duration: 0.2), value: isGenerating)
        .animation(.easeInOut(duration: 0.2), value: canSend)
    }
    
    private var sendButtonDisabled: Bool {
        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private func sendButtonAction() {
        if isGenerating {
            onStop?()
        } else {
            triggerHaptic()
            onSend()
        }
    }
    
    @ViewBuilder
    private var inputBackground: some View {
        if #available(iOS 26.0, *) {
            Color.clear.background(.ultraThinMaterial)
        } else {
            Color.clear.background(.ultraThinMaterial)
        }
    }
    
    @ViewBuilder
    private var textFieldBackground: some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            RoundedRectangle(cornerRadius: 22)
                .fill(.ultraThinMaterial)
                .glassEffect(.clear.interactive(), in: RoundedRectangle(cornerRadius: 22))
        } else {
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.secondary.opacity(0.1))
        }
    }
    
    @ViewBuilder
    private var sendButtonBackground: some View {
        if #available(iOS 26.0, *) {
            Color.secondary.opacity(0.12)
        } else {
            Color.secondary.opacity(0.12)
        }
    }
    
    private func triggerHaptic() {
        #if os(iOS)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        #endif
    }
}

// MARK: - Attachment Chip

public struct HaploAttachmentChip: View {
    let title: String
    let icon: String
    let onRemove: (() -> Void)?
    
    public init(
        title: String,
        icon: String = "doc.fill",
        onRemove: (() -> Void)? = nil
    ) {
        self.title = title
        self.icon = icon
        self.onRemove = onRemove
    }
    
    public var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(.accentColor)
            
            Text(title)
                .font(.haploCaption())
                .fontWeight(.medium)
                .foregroundColor(.text1)
                .lineLimit(1)
                .truncationMode(.middle)
            
            if let onRemove = onRemove {
                Button(action: onRemove) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.caption)
                        .foregroundColor(.text3)
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(Color.accentColor.opacity(0.1))
                .stroke(Color.accentColor.opacity(0.3), lineWidth: 1)
        )
    }
}

// MARK: - Tool Selection Chip

public struct HaploToolChip: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let onTap: () -> Void
    
    public init(
        title: String,
        icon: String,
        isSelected: Bool,
        onTap: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isSelected = isSelected
        self.onTap = onTap
    }
    
    public var body: some View {
        Button(action: {
            triggerHaptic()
            onTap()
        }) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundColor(isSelected ? .accentColor : .text2)
                
                Text(title)
                    .font(.haploCaption())
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .text1 : .text2)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(chipBackground)
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private var chipBackground: some View {
        if isSelected {
            Capsule()
                .fill(Color.accentColor.opacity(0.15))
                .stroke(Color.accentColor.opacity(0.4), lineWidth: 1)
        } else {
            Capsule()
                .fill(Color.secondary.opacity(0.08))
                .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
        }
    }
    
    private func triggerHaptic() {
        #if os(iOS)
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        #endif
    }
}

// MARK: - Preview

#Preview {
    struct ChatInputDemo: View {
        @State private var text = ""
        @State private var isGenerating = false
        
        var body: some View {
            VStack {
                Spacer()
                
                // Attachment chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        HaploToolChip(title: "Search", icon: "magnifyingglass", isSelected: true) {}
                        HaploToolChip(title: "Maps", icon: "map", isSelected: false) {}
                    }
                    .padding(.horizontal)
                }
                
                HaploChatInputBar(
                    text: $text,
                    isGenerating: isGenerating,
                    onSend: {
                        isGenerating = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isGenerating = false
                            text = ""
                        }
                    },
                    onStop: {
                        isGenerating = false
                    }
                )
            }
        }
    }
    
    return ChatInputDemo()
}
