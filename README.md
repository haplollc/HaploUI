# HaploUI

Common SwiftUI component library for all Haplo apps.

## Installation

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/haplollc/HaploUI.git", from: "1.0.0")
]
```

Or add via Xcode: File → Add Package Dependencies → `https://github.com/haplollc/HaploUI`

## Usage

```swift
import HaploUI

struct ContentView: View {
    var body: some View {
        VStack {
            HaploButton("Get Started", icon: "arrow.right") {
                // action
            }
            
            HaploTextField(text: $email, placeholder: "Email", icon: "envelope")
            
            HaploStatCard(title: "Workouts", value: "24", trend: .up("+12%"))
        }
    }
}
```

## Component Catalog

To browse all components, use the built-in catalog:

```swift
import HaploUI

struct CatalogApp: App {
    var body: some Scene {
        WindowGroup {
            ComponentCatalog()
        }
    }
}
```

## Components

### Buttons
- `HaploButton` - Standard button with styles (primary, secondary, tertiary, destructive, ghost, outline)
- `HaploIconButton` - Circular icon button

### Sheets
- `HaploSheet` - Standard sheet container
- `HaploActionSheet` - Action menu sheet
- `HaploConfirmationSheet` - Confirmation dialog

### Inputs
- `HaploTextField` - Text input with icon, label, and error state
- `HaploTextArea` - Multi-line text input
- `HaploSearchField` - Search bar
- `HaploToggle` - Toggle switch with label and subtitle

### Sliders & Steppers
- `HaploSlider` - Standard slider with label
- `HaploRangeSlider` - Range selection slider
- `HaploStepper` - Standard stepper
- `HaploCompactStepper` - Compact +/- stepper
- `HaploWheelStepper` - Wheel picker stepper

### Text & Labels
- `HaploText` - Styled text
- `HaploLabel` - Label with icon
- `HaploBadge` - Colored badge
- `HaploChip` - Selectable chip/tag

### Cards
- `HaploCard` - Generic card container
- `HaploInfoCard` - Info row card with icon
- `HaploStatCard` - Statistics card with trend

## Theme

Access theme values via `HaploTheme`:

```swift
// Colors
HaploTheme.Colors.primary
HaploTheme.Colors.secondaryBackground

// Spacing
HaploTheme.Spacing.md  // 12pt

// Corner Radius
HaploTheme.CornerRadius.lg  // 16pt

// Typography
HaploTheme.Typography.headline

// Animation
HaploTheme.Animation.spring
```

## License

MIT
