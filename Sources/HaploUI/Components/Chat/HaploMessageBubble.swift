//
//  HaploMessageBubble.swift
//  HaploUI
//
//  Message bubble component extracted from Haplo production apps.
//  Original sources: HaploAI, chalk
//

import SwiftUI

// MARK: - Message Role

public enum HaploMessageRole {
    case user
    case assistant
    case system
}

// MARK: - Message Bubble

public struct HaploMessageBubble: View {
    let content: String
    let role: HaploMessageRole
    let timestamp: Date?
    let isStreaming: Bool
    
    public init(
        content: String,
        role: HaploMessageRole,
        timestamp: Date? = nil,
        isStreaming: Bool = false
    ) {
        self.content = content
        self.role = role
        self.timestamp = timestamp
        self.isStreaming = isStreaming
    }
    
    private var isUser: Bool { role == .user }
    
    public var body: some View {
        HStack {
            if isUser { Spacer(minLength: 60) }
            
            VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
                bubbleContent
                
                if let timestamp = timestamp {
                    Text(timestamp, style: .time)
                        .font(.haploCaption2())
                        .foregroundColor(.text3)
                }
            }
            
            if !isUser { Spacer(minLength: 60) }
        }
    }
    
    @ViewBuilder
    private var bubbleContent: some View {
        Text(content)
            .font(.haploBody())
            .foregroundColor(isUser ? .white : .text1)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(bubbleBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .opacity(isStreaming ? 0.8 : 1.0)
    }
    
    @ViewBuilder
    private var bubbleBackground: some View {
        if isUser {
            Color.accentColor
        } else {
            Color.background3
        }
    }
}

// MARK: - Thinking Indicator

/// Animated indicator for when AI is "thinking"
public struct HaploThinkingIndicator: View {
    let thinkingContent: String?
    let isCurrentlyThinking: Bool
    
    @State private var isExpanded: Bool = false
    
    public init(
        thinkingContent: String? = nil,
        isCurrentlyThinking: Bool = true
    ) {
        self.thinkingContent = thinkingContent
        self.isCurrentlyThinking = isCurrentlyThinking
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            header
            
            if let content = thinkingContent, !content.isEmpty {
                expandedContent(content)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color.background2.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture {
            withAnimation(.snappy(duration: 0.2)) {
                isExpanded.toggle()
            }
        }
    }
    
    @ViewBuilder
    private var header: some View {
        HStack(spacing: 6) {
            if isCurrentlyThinking {
                ThinkingPulseIcon()
            } else {
                Image(systemName: "brain")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Text("Thinking...")
                .font(.haploCaption())
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            if thinkingContent != nil {
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
        }
    }
    
    @ViewBuilder
    private func expandedContent(_ content: String) -> some View {
        if isExpanded {
            ScrollView {
                Text(content)
                    .font(.haploCaption())
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxHeight: 200)
        } else {
            Text(content.prefix(100) + (content.count > 100 ? "..." : ""))
                .font(.haploCaption())
                .foregroundStyle(.tertiary)
                .lineLimit(2)
        }
    }
}

/// Animated pulsing brain icon
public struct ThinkingPulseIcon: View {
    @State private var isPulsing = false
    
    public init() {}
    
    public var body: some View {
        Image(systemName: "brain")
            .font(.caption)
            .foregroundStyle(.secondary)
            .scaleEffect(isPulsing ? 1.1 : 0.9)
            .opacity(isPulsing ? 1.0 : 0.6)
            .animation(
                .easeInOut(duration: 0.8)
                .repeatForever(autoreverses: true),
                value: isPulsing
            )
            .onAppear {
                isPulsing = true
            }
    }
}

// MARK: - Typing Indicator

/// Classic three-dot typing indicator
public struct HaploTypingIndicator: View {
    @State private var animatedDots: Int = 0
    
    public init() {}
    
    public var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .fill(Color.text3)
                    .frame(width: 8, height: 8)
                    .scaleEffect(animatedDots == index ? 1.2 : 0.8)
                    .animation(
                        .easeInOut(duration: 0.4)
                        .repeatForever(autoreverses: true)
                        .delay(Double(index) * 0.15),
                        value: animatedDots
                    )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.background3)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                animatedDots = (animatedDots + 1) % 3
            }
        }
    }
}

// MARK: - Preview

#Preview("Message Bubbles") {
    VStack(spacing: 16) {
        HaploMessageBubble(
            content: "Hello! How can I help you today?",
            role: .assistant,
            timestamp: Date()
        )
        
        HaploMessageBubble(
            content: "What's the weather like?",
            role: .user,
            timestamp: Date()
        )
        
        HaploThinkingIndicator(
            thinkingContent: "Let me check the weather API for your location...",
            isCurrentlyThinking: true
        )
        
        HaploTypingIndicator()
    }
    .padding()
}
