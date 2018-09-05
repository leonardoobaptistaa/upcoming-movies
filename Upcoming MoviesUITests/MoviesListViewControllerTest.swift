//
//  MoviesListViewControllerTest.swift
//  Upcoming MoviesUITests
//
//  Created by Leonardo Baptista on 9/5/18.
//

import XCTest
import Nimble

class MoviesListViewControllerTest: TestHelper {
        
    func testScrollToBottomLoadsMoreMovies() {
        expect(self.app.tables.cells.count).to(equal(20))
        expect(self.app.tables.cells.staticTexts["Teen Titans Go! To the Movies"].exists).to(beFalsy())
        
        dynamicStubs.setupStub(url: "/movie/upcoming", filename: "upcoming-page-2")
        app.swipeUp()
        
        expect(self.app.tables.cells.count).toEventually(equal(40))
        expect(self.app.tables.cells.staticTexts["Teen Titans Go! To the Movies"].exists).toEventually(beTruthy())
    }
    
}
