import SwiftUI

public struct InputsCatalog: View {
    @State private var basicText = ""
    @State private var rotatingText = ""
    @State private var labeledText = ""
    @State private var emailText = "invalid-email"
    @State private var password = ""
    @State private var notes = ""
    @State private var search = ""
    @State private var toggle1 = true
    @State private var toggle2 = false
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                // Basic Text Field (Rounded)
                CatalogSection("Text Field (Rounded)") {
                    HaploTextField(
                        text: $basicText,
                        placeholder: "Enter something..."
                    )
                }
                
                // With Optional Label
                CatalogSection("With Optional Label") {
                    HaploTextField(
                        text: $basicText,
                        placeholder: "Add notes about your workout",
                        optionalLabel: "optional"
                    )
                }
                
                // Rotating Placeholders
                CatalogSection("Rotating Placeholders") {
                    HaploTextField(
                        text: $rotatingText,
                        placeholders: [
                            "What would you like to create?",
                            "Try: A morning yoga routine",
                            "Try: HIIT workout for beginners",
                            "Try: 30-minute strength training"
                        ]
                    )
                }
                
                // Labeled Text Field
                CatalogSection("Labeled Text Field") {
                    HaploLabeledTextField(
                        text: $labeledText,
                        label: "Name",
                        placeholder: "Enter your name"
                    )
                }
                
                // With Icon
                CatalogSection("With Icon") {
                    HaploLabeledTextField(
                        text: $emailText,
                        label: "Email",
                        placeholder: "you@example.com",
                        icon: "envelope"
                    )
                }
                
                // With Error
                CatalogSection("With Error") {
                    HaploLabeledTextField(
                        text: $emailText,
                        label: "Email",
                        placeholder: "you@example.com",
                        icon: "envelope",
                        errorMessage: "Please enter a valid email address"
                    )
                }
                
                // Password Field
                CatalogSection("Password Field") {
                    HaploSecureField(
                        text: $password,
                        label: "Password",
                        placeholder: "Enter your password"
                    )
                }
                
                // Password With Error
                CatalogSection("Password With Error") {
                    HaploSecureField(
                        text: $password,
                        label: "Password",
                        placeholder: "Enter your password",
                        errorMessage: "Password must be at least 8 characters"
                    )
                }
                
                // Text Area
                CatalogSection("Text Area") {
                    HaploTextArea(
                        text: $notes,
                        placeholder: "Write your notes here...",
                        label: "Notes"
                    )
                }
                
                // Search Field
                CatalogSection("Search Field") {
                    HaploSearchField(
                        text: $search,
                        placeholder: "Search workouts"
                    )
                }
                
                // Toggles
                CatalogSection("Toggles") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploToggle(
                            isOn: $toggle1,
                            label: "Enable Notifications"
                        )
                        
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
                
                // Form Pattern
                CatalogSection("Form Pattern") {
                    VStack(spacing: HaploTheme.Spacing.md) {
                        HaploLabeledTextField(
                            text: $labeledText,
                            label: "Full Name",
                            placeholder: "John Doe",
                            icon: "person"
                        )
                        
                        HaploLabeledTextField(
                            text: $emailText,
                            label: "Email Address",
                            placeholder: "john@example.com",
                            icon: "envelope"
                        )
                        
                        HaploSecureField(
                            text: $password,
                            label: "Password"
                        )
                        
                        HaploPrimaryButton("Create Account") {}
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
