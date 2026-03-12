import SwiftUI

public struct SheetsCatalog: View {
    @State private var showSheet = false
    @State private var showActionSheet = false
    @State private var showConfirmation = false
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Standard Sheet") {
                    HaploButton("Show Sheet", style: .primary) {
                        showSheet = true
                    }
                }
                
                CatalogSection("Action Sheet") {
                    HaploButton("Show Action Sheet", style: .secondary) {
                        showActionSheet = true
                    }
                }
                
                CatalogSection("Confirmation Sheet") {
                    HaploButton("Show Confirmation", style: .destructive) {
                        showConfirmation = true
                    }
                }
                
                // Inline preview
                CatalogSection("Sheet Preview (Inline)") {
                    VStack(spacing: 0) {
                        HaploSheet(
                            title: "Sheet Title",
                            subtitle: "Optional subtitle text"
                        ) {
                            VStack(spacing: HaploTheme.Spacing.md) {
                                Text("Sheet content goes here")
                                    .font(HaploTheme.Typography.body)
                                    .foregroundColor(HaploTheme.Colors.secondaryLabel)
                                    .padding()
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.lg))
                    .haploShadow(HaploTheme.Shadows.lg)
                }
                
                CatalogSection("Action Sheet Preview (Inline)") {
                    VStack(spacing: 0) {
                        HaploActionSheet(
                            title: "Select Action",
                            message: "Choose what you'd like to do",
                            actions: [
                                .init(title: "Edit", icon: "pencil") {},
                                .init(title: "Duplicate", icon: "doc.on.doc") {},
                                .init(title: "Delete", icon: "trash", style: .destructive) {},
                            ]
                        )
                    }
                    .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.lg))
                    .haploShadow(HaploTheme.Shadows.lg)
                }
                
                CatalogSection("Confirmation Sheet Preview (Inline)") {
                    VStack(spacing: 0) {
                        HaploConfirmationSheet(
                            title: "Delete Item?",
                            message: "This action cannot be undone. Are you sure you want to continue?",
                            confirmTitle: "Delete",
                            confirmStyle: .destructive,
                            onConfirm: {},
                            onCancel: {}
                        )
                    }
                    .clipShape(RoundedRectangle(cornerRadius: HaploTheme.CornerRadius.lg))
                    .haploShadow(HaploTheme.Shadows.lg)
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
        .navigationTitle("Sheets")
        .sheet(isPresented: $showSheet) {
            HaploSheet(
                title: "Sheet Title",
                subtitle: "This is a standard sheet"
            ) {
                VStack {
                    Text("Sheet content")
                        .padding()
                    Spacer()
                }
            }
            .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $showActionSheet) {
            HaploActionSheet(
                title: "Actions",
                actions: [
                    .init(title: "Share", icon: "square.and.arrow.up") { showActionSheet = false },
                    .init(title: "Edit", icon: "pencil") { showActionSheet = false },
                    .init(title: "Delete", icon: "trash", style: .destructive) { showActionSheet = false },
                ]
            )
            .presentationDetents([.height(280)])
        }
        .sheet(isPresented: $showConfirmation) {
            HaploConfirmationSheet(
                title: "Confirm Delete",
                message: "This action cannot be undone.",
                confirmTitle: "Delete",
                confirmStyle: .destructive,
                onConfirm: { showConfirmation = false },
                onCancel: { showConfirmation = false }
            )
            .presentationDetents([.height(220)])
        }
    }
}

#Preview {
    NavigationStack {
        SheetsCatalog()
    }
}
