import SwiftUI

public struct ButtonsCatalog: View {
    @State private var isLoading = false
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Glass Icon Buttons") {
                        Text("Frosted glass circles for toolbars")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 12) {
                            HaploGlassIconButton(systemName: "brain") {}
                            HaploGlassIconButton(systemName: "heart.fill") {}
                            HaploGlassIconButton(systemName: "star.fill") {}
                            HaploGlassIconButton(systemName: "bookmark.fill") {}
                            Spacer()
                        }
                        
                        Text("With color tints")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 8)
                        
                        HStack(spacing: 12) {
                            HaploGlassIconButton(systemName: "heart.fill", tint: .red) {}
                            HaploGlassIconButton(systemName: "star.fill", tint: .yellow) {}
                            HaploGlassIconButton(systemName: "leaf.fill", tint: .green) {}
                            Spacer()
                        }
                    }
                    
                    CatalogSection("Unified Buttons") {
                        Text("Consistent button styles across the app")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
                            HaploButton("Primary", style: .primary) {}
                            HaploButton("Secondary", style: .secondary) {}
                            HaploButton("Tertiary", style: .tertiary) {}
                            HaploButton("Destructive", style: .destructive) {}
                            HaploButton("Outline", style: .outline) {}
                        }
                    }
                    
                    CatalogSection("Button Sizes") {
                        Text("Adapts to different UI contexts")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
                            HaploButton("Small", size: .small) {}
                            HaploButton("Medium", size: .medium) {}
                            HaploButton("Large", size: .large) {}
                        }
                    }
                    
                    CatalogSection("With Icons") {
                        Text("Icons enhance visual hierarchy")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 12) {
                            HaploButton("Add Item", icon: "plus") {}
                            HaploButton("Download", icon: "arrow.down.circle") {}
                            HaploButton("Share", icon: "square.and.arrow.up", style: .secondary) {}
                            HaploButton("Delete", icon: "trash", style: .destructive) {}
                        }
                    }
                    
                    CatalogSection("Full Width") {
                        Text("Spans the container for primary actions")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploButton("Continue", icon: "arrow.right", isFullWidth: true) {}
                    }
                    
                    CatalogSection("Loading State") {
                        Text("Shows progress during async operations")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 16) {
                            HaploButton("Submit", isLoading: isLoading) {}
                            
                            Button(isLoading ? "Stop" : "Start") {
                                withAnimation(.spring(response: 0.3)) {
                                    isLoading.toggle()
                                }
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                    
                    CatalogSection("Icon Buttons") {
                        Text("Compact buttons for toolbars")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 16) {
                            HaploIconButton(icon: "heart.fill", style: .primary) {}
                            HaploIconButton(icon: "bookmark.fill", style: .secondary) {}
                            HaploIconButton(icon: "ellipsis", style: .tertiary) {}
                            HaploIconButton(icon: "xmark", style: .ghost) {}
                            Spacer()
                        }
                    }
                    
                    CatalogSection("Capsule Buttons") {
                        Text("Glass capsule style from Chalk")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 12) {
                            HaploCapsuleButton("Filter") {}
                            HaploCapsuleButton("Sort", systemImage: "arrow.up.arrow.down") {}
                            Spacer()
                        }
                    }
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Buttons")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
    }
}

#Preview {
    NavigationStack {
        ButtonsCatalog()
    }
}
