//
//  KANOUITests.swift
//  KANOUITests
//
//  Created by 陳駿逸 on 2018/8/11.
//  Copyright © 2018年 陳駿逸. All rights reserved.
//

import XCTest

class KANOUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCUIDevice.shared.orientation = .faceUp
        XCUIDevice.shared.orientation = .portrait
        
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Patient Zero"]/*[[".cells.staticTexts[\"Patient Zero\"]",".staticTexts[\"Patient Zero\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Book The Movie"].tap()
        app.navigationBars["KANO.WebView"].buttons["Patient Zero"].tap()
        app.navigationBars["Patient Zero"].buttons["CINEMA"].tap()
        
        let cinemaNavigationBar = app.navigationBars["CINEMA"]
        cinemaNavigationBar.buttons["Refresh"].tap()
        cinemaNavigationBar.buttons["Clear"].tap()
        
    }
}
