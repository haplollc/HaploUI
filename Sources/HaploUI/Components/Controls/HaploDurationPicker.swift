import SwiftUI

// MARK: - Duration Picker

/// Duration picker that shows hours, minutes, and seconds
/// Stores the total duration as seconds
#if os(iOS)
public struct HaploDurationPicker: View {
    @Binding var totalSeconds: Int
    let showHours: Bool
    let showSeconds: Bool
    
    public init(
        totalSeconds: Binding<Int>,
        showHours: Bool = true,
        showSeconds: Bool = true
    ) {
        self._totalSeconds = totalSeconds
        self.showHours = showHours
        self.showSeconds = showSeconds
    }
    
    private var hours: Int {
        totalSeconds / 3600
    }
    
    private var minutes: Int {
        (totalSeconds % 3600) / 60
    }
    
    private var seconds: Int {
        totalSeconds % 60
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            if showHours {
                // Hours
                Picker("", selection: Binding(
                    get: { hours },
                    set: { newHours in
                        totalSeconds = (newHours * 3600) + (minutes * 60) + (showSeconds ? seconds : 0)
                    }
                )) {
                    ForEach(0..<24, id: \.self) { hour in
                        Text("\(hour)").tag(hour)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 60)
                .clipped()
                
                Text("h")
                    .font(HaploTheme.Typography.body)
                    .foregroundColor(.primary)
            }
            
            // Minutes
            Picker("", selection: Binding(
                get: { minutes },
                set: { newMinutes in
                    totalSeconds = (showHours ? hours * 3600 : 0) + (newMinutes * 60) + (showSeconds ? seconds : 0)
                }
            )) {
                ForEach(0..<60, id: \.self) { minute in
                    Text("\(minute)").tag(minute)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 60)
            .clipped()
            
            Text("m")
                .font(HaploTheme.Typography.body)
                .foregroundColor(.primary)
            
            if showSeconds {
                // Seconds
                Picker("", selection: Binding(
                    get: { seconds },
                    set: { newSeconds in
                        totalSeconds = (showHours ? hours * 3600 : 0) + (minutes * 60) + newSeconds
                    }
                )) {
                    ForEach(0..<60, id: \.self) { second in
                        Text("\(second)").tag(second)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 60)
                .clipped()
                
                Text("s")
                    .font(HaploTheme.Typography.body)
                    .foregroundColor(.primary)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
#else
public struct HaploDurationPicker: View {
    @Binding var totalSeconds: Int
    let showHours: Bool
    let showSeconds: Bool
    
    public init(
        totalSeconds: Binding<Int>,
        showHours: Bool = true,
        showSeconds: Bool = true
    ) {
        self._totalSeconds = totalSeconds
        self.showHours = showHours
        self.showSeconds = showSeconds
    }
    
    private var hours: Int {
        totalSeconds / 3600
    }
    
    private var minutes: Int {
        (totalSeconds % 3600) / 60
    }
    
    private var seconds: Int {
        totalSeconds % 60
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            if showHours {
                Stepper(value: Binding(
                    get: { hours },
                    set: { newHours in
                        totalSeconds = (newHours * 3600) + (minutes * 60) + (showSeconds ? seconds : 0)
                    }
                ), in: 0...23) {
                    Text("\(hours)h")
                }
            }
            
            Stepper(value: Binding(
                get: { minutes },
                set: { newMinutes in
                    totalSeconds = (showHours ? hours * 3600 : 0) + (newMinutes * 60) + (showSeconds ? seconds : 0)
                }
            ), in: 0...59) {
                Text("\(minutes)m")
            }
            
            if showSeconds {
                Stepper(value: Binding(
                    get: { seconds },
                    set: { newSeconds in
                        totalSeconds = (showHours ? hours * 3600 : 0) + (minutes * 60) + newSeconds
                    }
                ), in: 0...59) {
                    Text("\(seconds)s")
                }
            }
        }
    }
}
#endif

// MARK: - Time Picker

/// Simple time picker for hours and minutes
#if os(iOS)
public struct HaploTimePicker: View {
    @Binding var hour: Int
    @Binding var minute: Int
    let is24Hour: Bool
    
    public init(
        hour: Binding<Int>,
        minute: Binding<Int>,
        is24Hour: Bool = false
    ) {
        self._hour = hour
        self._minute = minute
        self.is24Hour = is24Hour
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            Picker("Hour", selection: $hour) {
                ForEach(is24Hour ? 0..<24 : 1..<13, id: \.self) { h in
                    Text("\(h)").tag(h)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 60)
            .clipped()
            
            Text(":")
                .font(.title2)
                .fontWeight(.semibold)
            
            Picker("Minute", selection: $minute) {
                ForEach(0..<60, id: \.self) { m in
                    Text(String(format: "%02d", m)).tag(m)
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 60)
            .clipped()
        }
    }
}
#else
public struct HaploTimePicker: View {
    @Binding var hour: Int
    @Binding var minute: Int
    let is24Hour: Bool
    
    public init(
        hour: Binding<Int>,
        minute: Binding<Int>,
        is24Hour: Bool = false
    ) {
        self._hour = hour
        self._minute = minute
        self.is24Hour = is24Hour
    }
    
    public var body: some View {
        HStack(spacing: 8) {
            Stepper(value: $hour, in: is24Hour ? 0...23 : 1...12) {
                Text(String(format: "%02d", hour))
            }
            
            Text(":")
                .font(.title2)
                .fontWeight(.semibold)
            
            Stepper(value: $minute, in: 0...59) {
                Text(String(format: "%02d", minute))
            }
        }
    }
}
#endif
