/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import XCTest

class NoImageTests: BaseTestCase {
    
    var navigator: Navigator!
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        navigator = createScreenGraph(app).navigator(self)
    }
    
    override func tearDown() {
        navigator = nil
        app = nil
        super.tearDown()
    }
    
    private func showImages() {
        app.buttons["TabToolbar.menuButton"].tap()
//        app.collectionViews.containing(.cell, identifier:"FindInPageMenuItem").element.swipeLeft()
        let tableViewsQuery = app.tables
        tableViewsQuery.cells["Hide Images: On"].tap()
    }
    
    private func hideImages() {
        app.buttons["TabToolbar.menuButton"].tap()
//        app.collectionViews.containing(.cell, identifier:"FindInPageMenuItem").element.swipeLeft()
        let tableViewsQuery = app.tables
        tableViewsQuery.cells["Hide Images: Off"].tap()
    }
    
    private func checkShowImages() {
        navigator.goto(BrowserTabMenu)
//        app.collectionViews.containing(.cell, identifier:"FindInPageMenuItem").element.swipeLeft()
        waitforExistence(app.tables.cells["Hide Images: On"])
//        navigator.goto(BrowserTab)
        app.buttons["Close"].tap()
    }
    
    private func checkHideImages() {
        navigator.goto(BrowserTabMenu)
//        app.collectionViews.containing(.cell, identifier:"FindInPageMenuItem").element.swipeLeft()
        waitforExistence(app.tables.cells["Hide Images: Off"])
//        navigator.goto(BrowserTab)
        app.buttons["Close"].tap()
    }
    
    func testImageOnOff() {
        let url1 = "www.google.com"
        
        // Go to a webpage, and select no images or hide images, check it's hidden or not
        navigator.openNewURL(urlString: url1)
        XCTAssertTrue(app.images.count > 1)
        hideImages()
        
        //After image is hidden, only image detected is the lock icon in the UI
        if iPad() {
            XCTAssertTrue(app.images.count == 2)
        } else {
            XCTAssertTrue(app.images.count == 1)
        }
        checkShowImages()
        
        // Load a same page on a new tab, check images are hidden
        navigator.openURL(urlString: url1)
        
        // Open it, then select show images it, and check it's showing the images
        showImages()
        XCTAssertTrue(app.images.count > 1)
        checkHideImages()
    }
    
}
