import SwiftUI

public struct SheetsCatalog: View {
    @State private var showSheet = false
    @State private var showActionSheet = false
    @State private var showConfirmation = false
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Standard Sheet") {
                        Text("Modal content presentation")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploPrimaryButton("Show Sheet") {
                            showSheet = true
                        }
                    }
                    
                    CatalogSection("Action Sheet") {
                        Text("Multiple options for user selection")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploSecondaryButton("Show Action Sheet") {
                            showActionSheet = true
                        }
                    }
                    
                    CatalogSection("Confirmation Sheet") {
                        Text("Confirm destructive or important actions")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploDestructiveButton("Show Confirmation") {
                            showConfirmation = true
                        }
                    }
                    
                    CatalogSection("Sheet Preview") {
                        Text("How sheets appear when presented")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 0) {
                            HaploSheet(
                                title: "Sheet Title",
                                subtitle: "Optional subtitle text"
                            ) {
                                VStack(spacing: 12) {
                                    Text("Sheet content goes here. This can contain any SwiftUI view.")
                                        .font(.haploBody())
                                        .foregroundStyle(Color.text2)
                                        .padding()
                                }
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .haploShadow(HaploTheme.Shadows.lg)
                    }
                    
                    CatalogSection("Action Sheet Preview") {
                        Text("List of contextual actions")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
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
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .haploShadow(HaploTheme.Shadows.lg)
                    }
                    
                    CatalogSection("Confirmation Preview") {
                        Text("Binary choice for critical decisions")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
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
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .haploShadow(HaploTheme.Shadows.lg)
                    }
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Sheets")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
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
