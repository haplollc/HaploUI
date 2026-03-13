import SwiftUI

public struct ChatCatalog: View {
    @State private var inputText = ""
    @State private var isGenerating = false
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Message Bubbles") {
                        Text("User and assistant message styles")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
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
                                content: "The weather in San Francisco is currently 68°F with partly cloudy skies. Perfect day for a walk!",
                                role: .assistant,
                                timestamp: Date()
                            )
                        }
                    }
                    
                    CatalogSection("Thinking Indicator") {
                        Text("Shows AI reasoning process")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
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
                        Text("Animated dots while composing")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            HaploTypingIndicator()
                            Spacer()
                        }
                    }
                    
                    CatalogSection("Thinking Pulse") {
                        Text("Compact thinking status")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 24) {
                            HStack(spacing: 6) {
                                ThinkingPulseIcon()
                                Text("Processing...")
                                    .font(.haploCaption())
                                    .foregroundStyle(Color.text2)
                            }
                            
                            HStack(spacing: 6) {
                                Image(systemName: "brain")
                                    .font(.caption)
                                    .foregroundStyle(Color.text3)
                                Text("Complete")
                                    .font(.haploCaption())
                                    .foregroundStyle(Color.text2)
                            }
                            
                            Spacer()
                        }
                    }
                    
                    CatalogSection("Tool Chips") {
                        Text("Show active AI capabilities")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
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
                        Text("File attachment previews")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                HaploAttachmentChip(title: "document.pdf", icon: "doc.fill") {}
                                HaploAttachmentChip(title: "photo.jpg", icon: "photo.fill") {}
                            }
                            
                            HaploAttachmentChip(title: "very_long_filename_example.txt", icon: "doc.text.fill") {}
                        }
                    }
                    
                    CatalogSection("Chat Input Bar") {
                        Text("Message composition with send/stop")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploChatInputBar(
                            text: $inputText,
                            placeholder: "Type a message...",
                            isGenerating: isGenerating,
                            onSend: {
                                withAnimation(.spring(response: 0.3)) {
                                    isGenerating = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation(.spring(response: 0.3)) {
                                        isGenerating = false
                                        inputText = ""
                                    }
                                }
                            },
                            onStop: {
                                withAnimation(.spring(response: 0.3)) {
                                    isGenerating = false
                                }
                            }
                        )
                    }
                    
                    CatalogSection("Streaming Message") {
                        Text("Message with typing cursor")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploMessageBubble(
                            content: "I'm currently typing this response...",
                            role: .assistant,
                            isStreaming: true
                        )
                    }
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Chat")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
    }
}

#Preview {
    NavigationStack {
        ChatCatalog()
    }
}
