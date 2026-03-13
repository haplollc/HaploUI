import SwiftUI

// MARK: - Component Catalog

public struct ComponentCatalog: View {
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.background1.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 10) {
                        // Components Section
                        CatalogSectionHeader("Components")
                        
                        VStack(spacing: 0) {
                            NavigationLink { ButtonsCatalog() } label: {
                                CatalogRow(icon: "rectangle.fill", title: "Buttons", subtitle: "Primary, secondary, icon buttons", count: 6)
                            }
                            CatalogDivider()
                            NavigationLink { SheetsCatalog() } label: {
                                CatalogRow(icon: "rectangle.bottomhalf.filled", title: "Sheets", subtitle: "Action sheets, confirmations", count: 3)
                            }
                            CatalogDivider()
                            NavigationLink { SlidersCatalog() } label: {
                                CatalogRow(icon: "slider.horizontal.3", title: "Sliders", subtitle: "Single and range sliders", count: 2)
                            }
                            CatalogDivider()
                            NavigationLink { SteppersCatalog() } label: {
                                CatalogRow(icon: "plusminus", title: "Steppers", subtitle: "Quantity controls", count: 4)
                            }
                            CatalogDivider()
                            NavigationLink { ControlsCatalog() } label: {
                                CatalogRow(icon: "dial.medium", title: "Controls", subtitle: "Pickers, segmented controls", count: 4)
                            }
                            CatalogDivider()
                            NavigationLink { TextCatalog() } label: {
                                CatalogRow(icon: "textformat", title: "Text & Labels", subtitle: "Typography, badges, chips", count: 4)
                            }
                            CatalogDivider()
                            NavigationLink { InputsCatalog() } label: {
                                CatalogRow(icon: "character.cursor.ibeam", title: "Inputs", subtitle: "Text fields, toggles", count: 4)
                            }
                            CatalogDivider()
                            NavigationLink { CardsCatalog() } label: {
                                CatalogRow(icon: "rectangle.on.rectangle", title: "Cards", subtitle: "Info cards, stat cards", count: 3)
                            }
                            CatalogDivider()
                            NavigationLink { ProgressCatalog() } label: {
                                CatalogRow(icon: "circle.dotted", title: "Progress", subtitle: "Radial, linear indicators", count: 5)
                            }
                            CatalogDivider()
                            NavigationLink { ChatCatalog() } label: {
                                CatalogRow(icon: "bubble.left.and.bubble.right", title: "Chat", subtitle: "Messages, input bars", count: 8)
                            }
                        }
                        .background(Color.background2)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        // Effects Section
                        CatalogSectionHeader("Effects")
                        
                        VStack(spacing: 0) {
                            NavigationLink { EffectsCatalog() } label: {
                                CatalogRow(icon: "sparkles", title: "Effects & Haptics", subtitle: "Glass, shimmer, confetti", count: 10)
                            }
                        }
                        .background(Color.background2)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        // Theme Section
                        CatalogSectionHeader("Theme")
                        
                        VStack(spacing: 0) {
                            NavigationLink { ColorsCatalog() } label: {
                                CatalogRow(icon: "paintpalette", title: "Colors", subtitle: "Semantic color system", count: 14)
                            }
                            CatalogDivider()
                            NavigationLink { TypographyCatalog() } label: {
                                CatalogRow(icon: "textformat.size", title: "Typography", subtitle: "Dynamic Type fonts", count: 11)
                            }
                            CatalogDivider()
                            NavigationLink { SpacingCatalog() } label: {
                                CatalogRow(icon: "arrow.left.and.right", title: "Spacing", subtitle: "Layout & corner radius", count: 8)
                            }
                        }
                        .background(Color.background2)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        Spacer().frame(height: 80)
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .navigationTitle("HaploUI")
        }
    }
}

// MARK: - Section Header

struct CatalogSectionHeader: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Text(title.uppercased())
                .font(.haploCaption(.semibold))
                .foregroundStyle(Color.text3)
                .tracking(0.5)
            Spacer()
        }
        .padding(.horizontal, 4)
        .padding(.top, 16)
        .padding(.bottom, 4)
    }
}

// MARK: - Catalog Row

struct CatalogRow: View {
    let icon: String
    let title: String
    var subtitle: String? = nil
    let count: Int
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.tint)
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.haploBody(.medium))
                    .foregroundStyle(Color.text1)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.haploCaption())
                        .foregroundStyle(Color.text3)
                }
            }
            
            Spacer()
            
            Text("\(count)")
                .font(.haploCaption(.medium))
                .foregroundStyle(Color.text2)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.background3)
                .clipShape(Capsule())
            
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color.text3)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .contentShape(Rectangle())
    }
}

// MARK: - Catalog Divider

struct CatalogDivider: View {
    var body: some View {
        Divider()
            .padding(.leading, 62)
    }
}

// MARK: - Section Component (for Catalog Pages)

struct CatalogSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.haploHeadline(.bold))
                .foregroundStyle(Color.text1)
            
            content
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.background2)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

// MARK: - Showcase Card (for displaying components)

struct ShowcaseCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Color.background3)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ComponentCatalog()
}
