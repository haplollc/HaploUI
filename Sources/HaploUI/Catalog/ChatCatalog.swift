import SwiftUI

public struct ChatCatalog: View {
    @State private var inputText = ""
    @State private var isGenerating = false
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Message Bubbles") {
                    VStack(spacing: 12) {
                        HaploMessageBubble(
                            content: "Hello! How can I help you today?",
                            role: .assistant,
                            timestamp: Date()
                        )
                        
                        HaploMessageBubble(
                            content: "What's the weather like in San Francisco?",
                            role: .user,
                            timestamp: Date()
                        )
                        
                        HaploMessageBubble(
                            content: "Let me check that for you. The weather in San Francisco is currently 68°F with partly cloudy skies.",
                            role: .assistant,
                            timestamp: Date()
                        )
                    }
                }
                
                CatalogSection("Thinking Indicator") {
                    VStack(spacing: 16) {
                        HaploThinkingIndicator(
                            thinkingContent: "Let me analyze the user's request and gather the relevant information...",
                            isCurrentlyThinking: true
                        )
                        
                        HaploThinkingIndicator(
                            thinkingContent: "Analysis complete. I found the information the user was looking for.",
                            isCurrentlyThinking: false
                        )
                    }
                }
                
                CatalogSection("Typing Indicator") {
                    HStack {
                        HaploTypingIndicator()
                        Spacer()
                    }
                }
                
                CatalogSection("Thinking Pulse Icon") {
                    HStack(spacing: 16) {
                        HStack(spacing: 6) {
                            ThinkingPulseIcon()
                            Text("Processing...")
                                .font(.haploCaption())
                                .foregroundColor(.text2)
                        }
                        
                        HStack(spacing: 6) {
                            Image(systemName: "brain")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("Complete")
                                .font(.haploCaption())
                                .foregroundColor(.text2)
                        }
                    }
                }
                
                CatalogSection("Tool Chips") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            HaploToolChip(title: "Search", icon: "magnifyingglass", isSelected: true) {}
                            HaploToolChip(title: "Maps", icon: "map", isSelected: false) {}
                            HaploToolChip(title: "Calendar", icon: "calendar", isSelected: false) {}
                            HaploToolChip(title: "Images", icon: "photo", isSelected: true) {}
                        }
                    }
                }
                
                CatalogSection("Attachment Chips") {
                    VStack(spacing: 8) {
                        HStack {
                            HaploAttachmentChip(title: "document.pdf", icon: "doc.fill") {}
                            HaploAttachmentChip(title: "photo.jpg", icon: "photo.fill") {}
                        }
                        
                        HStack {
                            HaploAttachmentChip(title: "very_long_filename_that_should_truncate.txt", icon: "doc.text.fill") {}
                        }
                    }
                }
                
                CatalogSection("Chat Input Bar") {
                    VStack(spacing: 16) {
                        Text("Interactive Demo")
                            .font(.haploCaption())
                            .foregroundColor(.text3)
                        
                        HaploChatInputBar(
                            text: $inputText,
                            placeholder: "Type a message...",
                            isGenerating: isGenerating,
                            onSend: {
                                isGenerating = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    isGenerating = false
                                    inputText = ""
                                }
                            },
                            onStop: {
                                isGenerating = false
                            }
                        )
                    }
                }
                
                CatalogSection("Streaming Message") {
                    HaploMessageBubble(
                        content: "I'm currently typing this response...",
                        role: .assistant,
                        isStreaming: true
                    )
                }
                
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(Color.background1)
        .navigationTitle("Chat Components")
    }
}

#Preview {
    NavigationStack {
        ChatCatalog()
    }
}
