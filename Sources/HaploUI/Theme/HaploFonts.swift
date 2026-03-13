//
//  HaploFonts.swift
//  HaploUI
//
//  Dynamic Type scalable fonts extracted from Haplo production apps.
//  Original source: barrier_swiftui
//
//  These fonts automatically scale with the user's Dynamic Type settings
//  while maintaining the app's design intent.
//

import SwiftUI

// MARK: - Dynamic Type Scalable Fonts

public extension Font {
    
    /// Large Title equivalent (default 34, scales with .largeTitle)
    static func haploLargeTitle(_ weight: Weight = .regular) -> Font {
        .system(.largeTitle, design: .default, weight: weight)
    }

    /// Title (default 28, scales with .title)
    static func haploTitle(_ weight: Weight = .regular) -> Font {
        .system(.title, design: .default, weight: weight)
    }

    /// Title 2 (default 22, scales with .title2)
    static func haploTitle2(_ weight: Weight = .regular) -> Font {
        .system(.title2, design: .default, weight: weight)
    }

    /// Title 3 (default 20, scales with .title3)
    static func haploTitle3(_ weight: Weight = .regular) -> Font {
        .system(.title3, design: .default, weight: weight)
    }

    /// Headline (default 17, scales with .headline)
    static func haploHeadline(_ weight: Weight = .regular) -> Font {
        .system(.headline, design: .default, weight: weight)
    }

    /// Body (default 17, scales with .body)
    static func haploBody(_ weight: Weight = .regular) -> Font {
        .system(.body, design: .default, weight: weight)
    }

    /// Callout (default 16, scales with .callout)
    static func haploCallout(_ weight: Weight = .regular) -> Font {
        .system(.callout, design: .default, weight: weight)
    }

    /// Subheadline (default 15, scales with .subheadline)
    static func haploSubheadline(_ weight: Weight = .regular) -> Font {
        .system(.subheadline, design: .default, weight: weight)
    }

    /// Footnote (default 13, scales with .footnote)
    static func haploFootnote(_ weight: Weight = .regular) -> Font {
        .system(.footnote, design: .default, weight: weight)
    }

    /// Caption (default 12, scales with .caption)
    static func haploCaption(_ weight: Weight = .regular) -> Font {
        .system(.caption, design: .default, weight: weight)
    }

    /// Caption 2 (default 11, scales with .caption2)
    static func haploCaption2(_ weight: Weight = .regular) -> Font {
        .system(.caption2, design: .default, weight: weight)
    }
}

// MARK: - Fixed Size Fonts (Use sparingly)

public extension Font {
    
    /// Fixed size font that does NOT scale with Dynamic Type.
    /// Use only when absolutely necessary (e.g., tight UI constraints).
    static func haploFixed(_ size: CGFloat, weight: Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
    
    /// Monospaced font for code or technical content
    static func haploMono(_ style: TextStyle = .body, weight: Weight = .regular) -> Font {
        .system(style, design: .monospaced, weight: weight)
    }
    
    /// Rounded font for friendly UI elements
    static func haploRounded(_ style: TextStyle = .body, weight: Weight = .regular) -> Font {
        .system(style, design: .rounded, weight: weight)
    }
    
    /// Serif font for elegant content
    static func haploSerif(_ style: TextStyle = .body, weight: Weight = .regular) -> Font {
        .system(style, design: .serif, weight: weight)
    }
}

// MARK: - Accessibility Font Helpers

public extension View {
    
    /// Limits maximum Dynamic Type scale for this view.
    /// Useful for constrained layouts that break at extreme accessibility sizes.
    @ViewBuilder
    func limitDynamicTypeSize(to maxSize: DynamicTypeSize = .accessibility3) -> some View {
        self.dynamicTypeSize(...maxSize)
    }
    
    /// Ensures minimum tap target size for accessibility (44x44pt recommended by Apple).
    func accessibleTapTarget(minSize: CGFloat = 44) -> some View {
        self.frame(minWidth: minSize, minHeight: minSize)
    }
}
