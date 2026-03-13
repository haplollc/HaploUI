//
//  HaploColors.swift
//  HaploUI
//
//  Semantic color system extracted from Haplo production apps.
//  Original source: barrier_swiftui
//

import SwiftUI

// MARK: - Semantic Colors

public extension Color {
    
    // MARK: - Text Colors
    
    /// Primary text color - highest contrast, main content
    static var text1: Color {
        Color("text1", bundle: .module)
    }
    
    /// Secondary text color - supporting content, labels
    static var text2: Color {
        Color("text2", bundle: .module)
    }
    
    /// Tertiary text color - subtle hints, metadata
    static var text3: Color {
        Color("text3", bundle: .module)
    }
    
    // MARK: - Background Colors
    
    /// Primary background - main app background
    static var background1: Color {
        Color("background1", bundle: .module)
    }
    
    /// Secondary background - cards, elevated surfaces
    static var background2: Color {
        Color("background2", bundle: .module)
    }
    
    /// Tertiary background - nested elements, inputs
    static var background3: Color {
        Color("background3", bundle: .module)
    }
    
    // MARK: - Shadow
    
    /// Standard shadow color
    static var shadow: Color {
        Color("shadow", bundle: .module)
    }
    
    // MARK: - Goblin Mode Colors (Special Theme)
    
    /// Goblin mode text - primary
    static var goblinText1: Color {
        Color("goblinText1", bundle: .module)
    }
    
    /// Goblin mode text - secondary
    static var goblinText2: Color {
        Color("goblinText2", bundle: .module)
    }
    
    /// Goblin mode text - tertiary
    static var goblinText3: Color {
        Color("goblinText3", bundle: .module)
    }
    
    /// Goblin mode background - primary
    static var goblinBackground1: Color {
        Color("goblinBackground1", bundle: .module)
    }
    
    /// Goblin mode background - secondary
    static var goblinBackground2: Color {
        Color("goblinBackground2", bundle: .module)
    }
    
    /// Goblin mode background - tertiary
    static var goblinBackground3: Color {
        Color("goblinBackground3", bundle: .module)
    }
    
    /// Goblin mode accent
    static var goblinAccent: Color {
        Color("goblinAccent", bundle: .module)
    }
}

// MARK: - Semantic Color Protocol

/// Protocol for theme-aware color providers
public protocol HaploColorProvider {
    var text1: Color { get }
    var text2: Color { get }
    var text3: Color { get }
    var background1: Color { get }
    var background2: Color { get }
    var background3: Color { get }
    var accent: Color { get }
}

// MARK: - Default Theme

public struct HaploDefaultTheme: HaploColorProvider {
    public init() {}
    
    public var text1: Color { .text1 }
    public var text2: Color { .text2 }
    public var text3: Color { .text3 }
    public var background1: Color { .background1 }
    public var background2: Color { .background2 }
    public var background3: Color { .background3 }
    public var accent: Color { .accentColor }
}

// MARK: - Goblin Theme

public struct HaploGoblinTheme: HaploColorProvider {
    public init() {}
    
    public var text1: Color { .goblinText1 }
    public var text2: Color { .goblinText2 }
    public var text3: Color { .goblinText3 }
    public var background1: Color { .goblinBackground1 }
    public var background2: Color { .goblinBackground2 }
    public var background3: Color { .goblinBackground3 }
    public var accent: Color { .goblinAccent }
}

// MARK: - Environment Key

private struct HaploThemeKey: EnvironmentKey {
    static let defaultValue: any HaploColorProvider = HaploDefaultTheme()
}

public extension EnvironmentValues {
    var haploTheme: any HaploColorProvider {
        get { self[HaploThemeKey.self] }
        set { self[HaploThemeKey.self] = newValue }
    }
}

public extension View {
    /// Apply a Haplo color theme to the view hierarchy
    func haploTheme(_ theme: any HaploColorProvider) -> some View {
        environment(\.haploTheme, theme)
    }
}
