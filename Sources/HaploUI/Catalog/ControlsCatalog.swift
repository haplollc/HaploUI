import SwiftUI

public struct ControlsCatalog: View {
    @State private var selectedSegment = "Option 1"
    @State private var duration: Int = 3600
    @State private var hour = 10
    @State private var minute = 30
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: HaploTheme.Spacing.xl) {
                
                CatalogSection("Segmented Control") {
                    VStack(spacing: HaploTheme.Spacing.lg) {
                        HaploSegmentedControl(
                            options: ["Option 1", "Option 2", "Option 3"],
                            selection: $selectedSegment
                        )
                        
                        HaploSegmentedControl(
                            options: ["Day", "Week", "Month"],
                            selection: .constant("Week")
                        )
                    }
                }
                
                CatalogSection("Duration Picker") {
                    HaploDurationPicker(totalSeconds: $duration)
                        .frame(height: 120)
                }
                
                CatalogSection("Duration (Minutes Only)") {
                    HaploDurationPicker(
                        totalSeconds: $duration,
                        showHours: false,
                        showSeconds: false
                    )
                    .frame(height: 120)
                }
                
                CatalogSection("Time Picker") {
                    HaploTimePicker(hour: $hour, minute: $minute)
                        .frame(height: 120)
                }
            }
            .padding(HaploTheme.Spacing.lg)
        }
        .background(HaploTheme.Colors.background)
        .navigationTitle("Controls")
    }
}

#Preview {
    NavigationStack {
        ControlsCatalog()
    }
}
