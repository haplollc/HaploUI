import SwiftUI

public struct ControlsCatalog: View {
    @State private var selectedSegment = "Option 1"
    @State private var duration: Int = 3600
    @State private var hour = 10
    @State private var minute = 30
    
    public init() {}
    
    public var body: some View {
        ZStack(alignment: .top) {
            Color.background1.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    CatalogSection("Segmented Control") {
                        Text("Switch between related views or options")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(spacing: 16) {
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
                        Text("Hours, minutes, and seconds selection")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploDurationPicker(totalSeconds: $duration)
                            .frame(height: 120)
                    }
                    
                    CatalogSection("Minutes Only") {
                        Text("Simplified for minute-based inputs")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploDurationPicker(
                            totalSeconds: $duration,
                            showHours: false,
                            showSeconds: false
                        )
                        .frame(height: 120)
                    }
                    
                    CatalogSection("Time Picker") {
                        Text("Hour and minute selection")
                            .font(.haploCaption())
                            .foregroundStyle(Color.text3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HaploTimePicker(hour: $hour, minute: $minute)
                            .frame(height: 120)
                    }
                    
                    Spacer().frame(height: 80)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationTitle("Controls")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.large)
        #endif
    }
}

#Preview {
    NavigationStack {
        ControlsCatalog()
    }
}
