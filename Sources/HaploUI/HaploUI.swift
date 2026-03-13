// HaploUI - Common Component Library for Haplo Apps
// https://github.com/haplollc/HaploUI
//
// A collection of bespoke UI components extracted from Haplo production apps:
// - barrier_swiftui (Screen Time)
// - chalk (Chat)
// - HaploAI (AI Assistant)
// - haplo_invest (Investment)

import SwiftUI

// MARK: - Theme

// Re-export theme components
public typealias Theme = HaploTheme

// Colors (semantic color system from barrier_swiftui)
// Access via: Color.text1, Color.background1, etc.

// Fonts (Dynamic Type scalable from barrier_swiftui)
// Access via: Font.haploBody(), Font.haploHeadline(), etc.

// MARK: - Effects

// Shimmer effects (from chalk)
public typealias ShimmerView = HaploShimmerView
public typealias ShimmerText = HaploShimmerText
public typealias MapShimmer = HaploMapShimmer
public typealias Skeleton = HaploSkeleton

// Confetti celebration (from haplo_invest)
public typealias ConfettiPiece = HaploConfettiPiece
public typealias ConfettiContainer = HaploConfettiContainer

// MARK: - Buttons

// Note: Don't alias Button or ButtonStyle to avoid conflicts with SwiftUI
public typealias IconButton = HaploIconButton
public typealias CapsuleButton = HaploCapsuleButton
public typealias PrimaryButton = HaploPrimaryButton
public typealias SecondaryButton = HaploSecondaryButton
public typealias TertiaryButton = HaploTertiaryButton
public typealias DestructiveButton = HaploDestructiveButton

// MARK: - Controls

public typealias SegmentedControl = HaploSegmentedControl
public typealias IconSegmentedControl = HaploIconSegmentedControl

// MARK: - Sheets

public typealias Sheet = HaploSheet
public typealias ActionSheet = HaploActionSheet
public typealias ConfirmationSheet = HaploConfirmationSheet

// MARK: - Sliders

// Note: Don't alias Slider to avoid conflicts with SwiftUI
public typealias RangeSlider = HaploRangeSlider

// MARK: - Steppers

// Note: Don't alias Stepper to avoid conflicts with SwiftUI
public typealias CompactStepper = HaploCompactStepper
public typealias WheelStepper = HaploWheelStepper
public typealias BorderedStepper = HaploBorderedStepper

// MARK: - Text

// Note: Don't alias Label to avoid conflicts with SwiftUI
public typealias Badge = HaploBadge
public typealias Chip = HaploChip

// MARK: - Inputs

// Note: Don't alias TextField/Toggle to avoid conflicts with SwiftUI
public typealias RoundedTextField = HaploTextField
public typealias LabeledTextField = HaploLabeledTextField
// Note: Don't alias SecureField to avoid conflicts with SwiftUI
public typealias TextArea = HaploTextArea
public typealias SearchField = HaploSearchField
// Note: Don't alias Toggle to avoid conflicts with SwiftUI

// MARK: - Cards

public typealias Card = HaploCard
public typealias InfoCard = HaploInfoCard
public typealias StatCard = HaploStatCard

// MARK: - Chat (from HaploAI/chalk)

public typealias MessageBubble = HaploMessageBubble
public typealias MessageRole = HaploMessageRole
public typealias ChatInputBar = HaploChatInputBar
public typealias ThinkingIndicator = HaploThinkingIndicator
public typealias TypingIndicator = HaploTypingIndicator
public typealias AttachmentChip = HaploAttachmentChip
public typealias ToolChip = HaploToolChip

// MARK: - Color Provider Protocol

public typealias ColorProvider = HaploColorProvider
public typealias DefaultTheme = HaploDefaultTheme
public typealias GoblinTheme = HaploGoblinTheme
