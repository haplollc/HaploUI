import SwiftUI

public struct InputsCatalog: View {
    @State private var text = ""
    @State private var password = ""
    @State private var email = "test@example.com"
    @State private var notes = ""
    @State private var search = ""
    @State private var toggle1 = true
    @State private var toggle2 = false
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Text Field") {
                        Text("Basic text input with placeholder")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploTextField(
                            text: $text,
                            placeholder: "Enter your name"
                        )
                    }
                    
                    CatalogSection("Labeled Text Field") {
                        Text("Text field with floating label")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploLabeledTextField(
                            text: $email,
                            label: "Email",
                            placeholder: "you@example.com",
                            icon: "envelope"
                        )
                    }
                    
                    CatalogSection("Password Field") {
                        Text("Secure text entry with toggle")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploSecureField(
                            text: $password,
                            label: "Password",
                            placeholder: "Enter password"
                        )
                    }
                    
                    CatalogSection("Rotating Placeholders") {
                        Text("Cycle through example prompts")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploTextField(
                            text: $text,
                            placeholders: ["Run 5 miles", "Do 20 pushups", "Stretch for 10 minutes"]
                        )
                    }
                    
                    CatalogSection("Text Area") {
                        Text("Multi-line text input")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploTextArea(
                            text: $notes,
                            placeholder: "Write your notes here..."
                        )
                    }
                    
                    CatalogSection("Search Field") {
                        Text("Inline search with clear button")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploSearchField(text: $search, placeholder: "Search workouts")
                    }
                    
                    CatalogSection("Toggles") {
                        Text("On/off switches with labels")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 0) {
                            HaploToggle(isOn: $toggle1, label: "Enable Notifications")
                            
                            Divider()
                                .padding(.leading, 16)
                            
                            HaploToggle(
                                isOn: $toggle2,
                                label: "Dark Mode",
                                subtitle: "Use dark theme throughout the app",
                                icon: "moon.fill"
                            )
                            
                            Divider()
                                .padding(.leading, 16)
                            
                            HaploToggle(
                                isOn: $toggle1,
                                label: "Location Services",
                                subtitle: "Allow access to your location",
                                icon: "location.fill"
                            )
                        }
                        .background(Color.background3)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Inputs")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
    }
}

#Preview {
    NavigationStack {
        InputsCatalog()
    }
}
