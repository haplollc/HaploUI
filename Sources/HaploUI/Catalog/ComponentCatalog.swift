import SwiftUI

// MARK: - Component Catalog

public struct ComponentCatalog: View {
    public init() {}
    
    public var body: some View {
        NavigationStack {
            List {
                Section("Components") {
                    NavigationLink {
                        ButtonsCatalog()
                    } label: {
                        CatalogRow(icon: "rectangle.fill", title: "Buttons", count: 6)
                    }
                    
                    NavigationLink {
                        SheetsCatalog()
                    } label: {
                        CatalogRow(icon: "rectangle.bottomhalf.filled", title: "Sheets", count: 3)
                    }
                    
                    NavigationLink {
                        SlidersCatalog()
                    } label: {
                        CatalogRow(icon: "slider.horizontal.3", title: "Sliders", count: 2)
                    }
                    
                    NavigationLink {
                        SteppersCatalog()
                    } label: {
                        CatalogRow(icon: "plusminus", title: "Steppers", count: 4)
                    }
                    
                    NavigationLink {
                        ControlsCatalog()
                    } label: {
                        CatalogRow(icon: "dial.medium", title: "Controls", count: 4)
                    }
                    
                    NavigationLink {
                        TextCatalog()
                    } label: {
                        CatalogRow(icon: "textformat", title: "Text & Labels", count: 4)
                    }
                    
                    NavigationLink {
                        InputsCatalog()
                    } label: {
                        CatalogRow(icon: "character.cursor.ibeam", title: "Inputs", count: 4)
                    }
                    
                    NavigationLink {
                        CardsCatalog()
                    } label: {
                        CatalogRow(icon: "rectangle.on.rectangle", title: "Cards", count: 3)
                    }
                    
                    NavigationLink {
                        ProgressCatalog()
                    } label: {
                        CatalogRow(icon: "circle.dotted", title: "Progress", count: 5)
                    }
                    
                    NavigationLink {
                        ChatCatalog()
                    } label: {
                        CatalogRow(icon: "bubble.left.and.bubble.right", title: "Chat", count: 8)
                    }
                }
                
                Section("Effects") {
                    NavigationLink {
                        EffectsCatalog()
                    } label: {
                        CatalogRow(icon: "sparkles", title: "Effects & Haptics", count: 10)
                    }
                }
                
                Section("Theme") {
                    NavigationLink {
                        ColorsCatalog()
                    } label: {
                        CatalogRow(icon: "paintpalette", title: "Colors", count: 14)
                    }
                    
                    NavigationLink {
                        TypographyCatalog()
                    } label: {
                        CatalogRow(icon: "textformat.size", title: "Typography", count: 11)
                    }
                    
                    NavigationLink {
                        SpacingCatalog()
                    } label: {
                        CatalogRow(icon: "arrow.left.and.right", title: "Spacing", count: 8)
                    }
                }
            }
            .navigationTitle("HaploUI")
        }
    }
}

// MARK: - Catalog Row

struct CatalogRow: View {
    let icon: String
    let title: String
    let count: Int
    
    var body: some View {
        HStack(spacing: HaploTheme.Spacing.md) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(HaploTheme.Colors.primary)
                .frame(width: 32)
            
            Text(title)
                .font(.haploBody())
            
            Spacer()
            
            Text("\(count)")
                .font(.haploCaption())
                .foregroundColor(.text2)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.background2)
                .clipShape(Capsule())
        }
    }
}

// MARK: - Section Header

struct CatalogSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: HaploTheme.Spacing.md) {
            Text(title)
                .font(.haploHeadline())
                .foregroundColor(.text2)
            
            content
        }
    }
}
