//
//  TestHelper.swift
//  Upcoming MoviesUITests
//
//  Created by Leonardo Baptista on 9/5/18.
//

import XCTest

class TestHelper: XCTestCase {
    
    let app = XCUIApplication()
    let dynamicStubs = HTTPDynamicStubs()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        dynamicStubs.setUp()
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        dynamicStubs.tearDown()
    }
}
