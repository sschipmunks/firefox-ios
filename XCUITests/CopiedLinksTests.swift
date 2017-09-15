/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import XCTest

class CopiedLinksTests: BaseTestCase {
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
    
    // This test is enable Offer to open copied links, when opening firefox
    func testCopiedLinks() {
        navigator.goto(SettingsScreen)
        
        //Check Offer to open copied links, when opening firefox is off
        let value = app.tables.cells.switches["Offer to Open Copied Links, When Opening Firefox"].value
        XCTAssertEqual(value as? String, "0")

        //Switch on, Offer to open copied links, when opening firefox
        app.tables.cells.switches["Offer to Open Copied Links, When Opening Firefox"].tap()

        //Check Offer to open copied links, when opening firefox is on
        let value2 = app.tables.cells.switches["Offer to Open Copied Links, When Opening Firefox"].value
        XCTAssertEqual(value2 as? String, "1")

        app.navigationBars["Settings"]/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".buttons[\"Done\"]",".buttons[\"AppSettingsTableViewController.navigationItem.leftBarButtonItem\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()

        app/*@START_MENU_TOKEN@*/.buttons["TabToolbar.menuButton"]/*[[".buttons[\"Menu\"]",".buttons[\"TabToolbar.menuButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        let settingsmenuitemCell = app/*@START_MENU_TOKEN@*/.collectionViews.cells["SettingsMenuItem"]/*[[".otherElements[\"MenuViewController.menuView\"].collectionViews",".cells[\"Settings\"]",".cells[\"SettingsMenuItem\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        let settingsmenuitemCell = app.tables.cells["Settings"]
        settingsmenuitemCell.tap()

        //Check Offer to open copied links, when opening firefox is on
        let value3 = app.tables.cells.switches["Offer to Open Copied Links, When Opening Firefox"].value
        XCTAssertEqual(value3 as? String, "1")
    }
}
