//
//  MovieDetailViewControllerTest.swift
//  Upcoming MoviesUITests
//
//  Created by Leonardo Baptista on 9/5/18.
//

import XCTest
import Nimble

class MoviesDetailViewControllerTest: TestHelper {
    
    func testTapOnViewHidesInfos() {
        app.tables.cells.staticTexts["Alpha - MOCKED"].tap()
        
        expect(self.app.buttons["poster"].exists).to(beTruthy())
        expect(self.app.buttons["view infos"].exists).to(beTruthy())
        app.buttons["view infos"].tap()
        
        expect(self.app.buttons["view infos"].exists).to(beFalsy())
        
        app.buttons["poster"].tap()
        expect(self.app.buttons["view infos"].exists).to(beTruthy())
    }
    
    func testOpenMovieAndGoBack() {
        app.tables.cells.staticTexts["Alpha - MOCKED"].tap()
        app.navigationBars["Movie"].children(matching: .button).matching(identifier: "Upcoming Movies").element(boundBy: 0).tap()
        
        expect(self.app.tables.cells.staticTexts["Alpha - MOCKED"].exists).toEventually(beTruthy())
    }
}
