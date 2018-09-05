//
//  APIServiceTest.swift
//  Upcoming MoviesTests
//
//  Created by Leonardo Baptista on 9/3/18.
//

import XCTest
import OHHTTPStubs
import Nimble

@testable import Upcoming_Movies

class APIServiceTests: XCTestCase {
    var apiService = APIService()
        
    override func setUp() {
        super.setUp()
        stubUpcomingMoviesSuccess()
        apiService = APIService()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUpcomingMoviesSuccess() {
        var movies: [Movie] = []
        apiService.upcomingMovies(onSuccess: { (_movies) in
            movies = _movies
        }) { (messages) in
            
        }
        
        expect(movies.count).toEventually(equal(20))
    }
    
    func testUpcomingMoviesMockedSuccessParsesMoviesInfos() {
        stubUpcomingMoviesSuccess()
        
        var movies: [Movie] = []
        apiService.upcomingMovies(onSuccess: { (_movies) in
            movies = _movies
        }) { (messages) in
            
        }
        
        expect(movies.first?.name).toEventually(equal("Alpha - MOCKED"))
    }
    
    func stubUpcomingMoviesSuccess() {
        stub(condition: { (_) -> Bool in return true }) { request in
            let stubPath = OHPathForFile("upcoming.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
    }
}
