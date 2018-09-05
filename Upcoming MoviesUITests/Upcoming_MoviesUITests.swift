//
//  Upcoming_MoviesUITests.swift
//  Upcoming MoviesUITests
//
//  Created by Leonardo Baptista on 9/3/18.
//

import XCTest

class Upcoming_MoviesUITests: TestHelper {
    
    func testItLoadsMockedData() {
        XCTAssert(app.tables.cells.staticTexts["Alpha - MOCKED"].exists)
    }
}
