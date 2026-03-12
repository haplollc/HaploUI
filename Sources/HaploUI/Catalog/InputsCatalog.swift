import SwiftUI

public struct InputsCatalog: View {
    @State private var text = ""
    @State private var password = ""
    @State private var email = "invalid-email"
    @State private var notes = ""
    @State private var search = ""
    @State private var toggle1 = true
    @State private var toggle2 = false
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Text Field") {
                    HaploTextField(
                        text: $text,
                        placeholder: "Enter your name",
                        label: "Name"
                    )
                }
                
                CatalogSection("With Icon") {
                    HaploTextField(
                        text: $email,
                        placeholder: "you@example.com",
                        label: "Email",
                        icon: "envelope"
                    )
                }
                
                CatalogSection("Password Field") {
                    HaploTextField(
                        text: $password,
                        placeholder: "Enter password",
                        label: "Password",
                        icon: "lock",
                        isSecure: true
                    )
                }
                
                CatalogSection("With Error") {
                    HaploTextField(
                        text: $email,
                        placeholder: "you@example.com",
                        label: "Email",
                        icon: "envelope",
                        errorMessage: "Please enter a valid email address"
                    )
                }
                
                CatalogSection("Text Area") {
                    HaploTextArea(
                        text: $notes,
                        placeholder: "Write your notes here...",
                        label: "Notes"
                    )
                }
                
                CatalogSection("Search Field") {
                    HaploSearchField(text: $search, placeholder: "Search workouts")
                }
                
                CatalogSection("Toggles") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploToggle(isOn: $toggle1, label: "Enable Notifications")
                        
                        HaploToggle(
                            isOn: $toggle2,
                            label: "Dark Mode",
                            subtitle: "Use dark theme throughout the app",
                            icon: "moon.fill"
                        )
                        
                        HaploToggle(
                            isOn: $toggle1,
                            label: "Location Services",
                            subtitle: "Allow access to your location",
                            icon: "location.fill"
                        )
                    }
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
        .navigationTitle("Inputs")
    }
}

#Preview {
    NavigationStack {
        InputsCatalog()
    }
}
