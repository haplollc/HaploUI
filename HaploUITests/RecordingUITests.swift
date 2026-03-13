import XCTest

final class RecordingUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = true
        app.launchArguments = ["UI_TESTING"]
        app.launch()
    }
    
    func testNavigateAllSections() throws {
        sleep(2)
        
        // Navigate through each section
        let sections = ["Buttons", "Sheets", "Sliders", "Steppers", "Controls", 
                        "Text & Labels", "Inputs", "Cards", "Progress"]
        
        for section in sections {
            let cell = app.cells.staticTexts[section]
            if cell.waitForExistence(timeout: 3) {
                cell.tap()
                sleep(1)
                
                // Scroll down to show content
                let scrollView = app.scrollViews.firstMatch
                if scrollView.exists {
                    scrollView.swipeUp()
                    sleep(1)
                }
                
                // Go back
                let backButton = app.navigationBars.buttons.element(boundBy: 0)
                if backButton.exists {
                    backButton.tap()
                    sleep(1)
                }
            }
        }
        
        // Scroll to see Effects section
        app.swipeUp()
        sleep(1)
        
        // Navigate to Effects
        let effectsCell = app.cells.staticTexts["Effects & Haptics"]
        if effectsCell.waitForExistence(timeout: 3) {
            effectsCell.tap()
            sleep(1)
            app.swipeUp()
            sleep(1)
            app.navigationBars.buttons.element(boundBy: 0).tap()
        }
        
        sleep(2)
    }
}
