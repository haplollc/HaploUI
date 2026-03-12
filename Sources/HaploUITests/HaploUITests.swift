import Testing
@testable import HaploUI

@Suite("HaploUI Tests")
struct HaploUITests {
    
    @Test("Theme colors exist")
    func testThemeColors() {
        _ = HaploTheme.Colors.primary
        _ = HaploTheme.Colors.secondary
        _ = HaploTheme.Colors.success
        _ = HaploTheme.Colors.error
    }
    
    @Test("Theme spacing values")
    func testThemeSpacing() {
        #expect(HaploTheme.Spacing.xxs == 2)
        #expect(HaploTheme.Spacing.xs == 4)
        #expect(HaploTheme.Spacing.sm == 8)
        #expect(HaploTheme.Spacing.md == 12)
        #expect(HaploTheme.Spacing.lg == 16)
        #expect(HaploTheme.Spacing.xl == 24)
    }
    
    @Test("Corner radius values")
    func testCornerRadius() {
        #expect(HaploTheme.CornerRadius.sm == 6)
        #expect(HaploTheme.CornerRadius.md == 10)
        #expect(HaploTheme.CornerRadius.lg == 16)
    }
}
