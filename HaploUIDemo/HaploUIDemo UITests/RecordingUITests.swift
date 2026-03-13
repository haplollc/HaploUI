import XCTest

final class RecordingUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = true
        app.launch()
    }
    
    func testNavigateAllSections() throws {
        // Wait for app to load
        sleep(2)
        
        let sections = [
            "Buttons",
            "Sheets",
            "Sliders",
            "Steppers",
            "Controls",
            "Text & Labels",
            "Inputs",
            "Cards",
            "Progress"
        ]
        
        for section in sections {
            // Tap on section
            let cell = app.cells.containing(.staticText, identifier: section).firstMatch
            if cell.waitForExistence(timeout: 2) {
                cell.tap()
                
                // Wait and scroll
                sleep(1)
                app.swipeUp()
                sleep(1)
                app.swipeUp()
                sleep(1)
                
                // Go back
                app.navigationBars.buttons.firstMatch.tap()
                sleep(1)
            }
        }
        
        // Scroll to Effects section
        app.swipeUp()
        sleep(1)
        
        // Tap Effects
        let effectsCell = app.cells.containing(.staticText, identifier: "Effects & Haptics").firstMatch
        if effectsCell.waitForExistence(timeout: 2) {
            effectsCell.tap()
            sleep(1)
            app.swipeUp()
            sleep(1)
            app.swipeUp()
            sleep(1)
            app.navigationBars.buttons.firstMatch.tap()
        }
        
        sleep(2)
    }
}
