//
//  TestUIApp.swift
//  RemindMeUITests
//
//  Created by Binal Manek on 2023-05-11.
//

import XCTest

final class TestUIApp: XCTestCase {
    let springboard = XCUIApplication(bundleIdentifier: "com.binal.RemindMeUITests")

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//
//        // In UI tests it is usually best to stop immediately when a failure occurs.
//        continueAfterFailure = false
//
//        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
    
    override func tearDown() {
        super.tearDown()
        deleteMyApp()
    }
    func deleteMyApp() {
            XCUIApplication().terminate()
            
             // Force delete the app from the springboard
            let icon = springboard.icons["RemindMeUITests"]
            if icon.exists {
                let iconFrame = icon.frame
                let springboardFrame = springboard.frame
                icon.press(forDuration: 1.3)
            
                // Tap the little "X" button at approximately where it is. The X is not exposed directly
                springboard.coordinate(withNormalizedOffset: CGVector(dx: (iconFrame.minX + 3) / springboardFrame.maxX, dy: (iconFrame.minY + 3) / springboardFrame.maxY)).tap()
            
                springboard.alerts.buttons["Delete"].tap()
            }
        }
    func testAppFlow() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()

        let nameField = app/*@START_MENU_TOKEN@*/.textFields["Name"]/*[[".scrollViews.textFields[\"Name\"]",".textFields[\"Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let surnameField = app/*@START_MENU_TOKEN@*/.textFields["Surname"]/*[[".scrollViews.textFields[\"Surname\"]",".textFields[\"Surname\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let relationField = app/*@START_MENU_TOKEN@*/.textFields["Relation"]/*[[".scrollViews.textFields[\"Relation\"]",".textFields[\"Relation\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let phoneField = app/*@START_MENU_TOKEN@*/.textFields["Phone"]/*[[".scrollViews.textFields[\"Phone\"]",".textFields[\"Phone\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let dobField = app/*@START_MENU_TOKEN@*/.textFields["Date Of Birth"]/*[[".scrollViews.textFields[\"Date Of Birth\"]",".textFields[\"Date Of Birth\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let doaField = app/*@START_MENU_TOKEN@*/.textFields["Date Of Anniversary"]/*[[".scrollViews.textFields[\"Date Of Anniversary\"]",".textFields[\"Date Of Anniversary\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let emailField = app/*@START_MENU_TOKEN@*/.textFields["Email"]/*[[".scrollViews.textFields[\"Email\"]",".textFields[\"Email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let returnBtn = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let submitBtn = app/*@START_MENU_TOKEN@*/.buttons["Submit"]/*[[".scrollViews.buttons[\"Submit\"]",".buttons[\"Submit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let backBtn = app.navigationBars["Details"].buttons["List"]
        let addedCell = app.tables.staticTexts["Janak"]
        
        let collectionViewsQuery = app.datePickers.collectionViews
        let doneButton = app.toolbars["Toolbar"].buttons["Done"]

        app.launch()
        
        app.navigationBars["List"].buttons["add"].tap()
        nameField.tap()
        nameField.typeText("Janak")
        
        surnameField.tap()
        surnameField.typeText("Manek")
        
        relationField.tap()
        relationField.typeText("Husband")
        
        phoneField.tap()
        phoneField.typeText("4388686187")

        dobField.tap()
        collectionViewsQuery.buttons["Tuesday, May 2"].children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        doneButton.tap()
        
        doaField.tap()
        collectionViewsQuery.buttons["Saturday, May 27"].children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        doneButton.tap()
        
        emailField.tap()
        emailField.typeText("janakmanek@gmail.com")
        returnBtn.tap()
        submitBtn.tap()
        addedCell.tap()
        backBtn.tap()
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Janak"]/*[[".cells.staticTexts[\"Janak\"]",".staticTexts[\"Janak\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.textFields["Surname"]/*[[".scrollViews.textFields[\"Surname\"]",".textFields[\"Surname\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Submit"]/*[[".scrollViews.buttons[\"Submit\"]",".buttons[\"Submit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Submit"].tap()

        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Janak"]/*[[".cells.staticTexts[\"Janak\"]",".staticTexts[\"Janak\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        app.tables.buttons["Delete"].tap()
           
    }


}
