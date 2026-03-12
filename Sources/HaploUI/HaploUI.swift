// HaploUI - Common Component Library for Haplo Apps
// https://github.com/haplollc/HaploUI

import SwiftUI

// Re-export all public components
// Theme
public typealias Theme = HaploTheme

// Buttons
// Note: Don't alias Button or ButtonStyle to avoid conflicts with SwiftUI
public typealias IconButton = HaploIconButton

// Sheets
public typealias Sheet = HaploSheet
public typealias ActionSheet = HaploActionSheet
public typealias ConfirmationSheet = HaploConfirmationSheet

// Sliders
// Note: Don't alias Slider/Stepper to avoid conflicts with SwiftUI
public typealias RangeSlider = HaploRangeSlider

// Steppers
public typealias CompactStepper = HaploCompactStepper
public typealias WheelStepper = HaploWheelStepper

// Text
// Note: Don't alias Label to avoid conflicts with SwiftUI
public typealias Badge = HaploBadge
public typealias Chip = HaploChip

// Inputs
// Note: Don't alias TextField/Toggle to avoid conflicts with SwiftUI
public typealias TextArea = HaploTextArea
public typealias SearchField = HaploSearchField

// Cards
public typealias Card = HaploCard
public typealias InfoCard = HaploInfoCard
public typealias StatCard = HaploStatCard
