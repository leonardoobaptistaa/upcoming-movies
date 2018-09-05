//
//  MovieTest.swift
//  Upcoming MoviesTests
//
//  Created by Leonardo Baptista on 9/3/18.
//

import XCTest
import OHHTTPStubs
import Nimble
import ObjectMapper

@testable import Upcoming_Movies

class MovieTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func mappedMovie() -> Movie {
        let json: [String: Any] = [
            "vote_count": 96,
            "id": 399360,
            "video": false,
            "vote_average": 5.7,
            "title": "Mocked Movie Title",
            "popularity": 74.429,
            "poster_path": "/afdZAIcAQscziqVtsEoh2PwsYTW.jpg",
            "original_language": "en",
            "original_title": "Alpha",
            "backdrop_path": "/nKMeTdm72LQ756Eq20uTjF1zDXu.jpg",
            "adult": false,
            "overview": "After a hunting expedition goes awry, a young caveman struggles against the elements to find his way home.",
            "release_date": "2018-08-17",
            "genre_ids": [12, 18, 12376278]
        ]
        let mapper = Map(mappingType: .fromJSON, JSON: json)
        return Movie(map: mapper)!
    }
    
    func testName() {
        let movie = mappedMovie()
        expect(movie.name).to(equal("Mocked Movie Title"))
    }
    
    func testImageURLPath() {
        let movie = mappedMovie()
        expect(movie.imageURLPath).to(equal("https://image.tmdb.org/t/p/w500/afdZAIcAQscziqVtsEoh2PwsYTW.jpg"))
    }
    
    func testThumbURLPath() {
        let movie = mappedMovie()
        expect(movie.thumbURLPath).to(equal("https://image.tmdb.org/t/p/w92/afdZAIcAQscziqVtsEoh2PwsYTW.jpg"))
    }
    
    func testReleaseDate() {
        let movie = mappedMovie()
        let formatter = DateFormatter(withFormat: "yyyy-MM-dd", locale: "en")
        let textDate = formatter.string(from: movie.releaseDate)
        expect(textDate).to(equal("2018-08-17"))
    }
    
    func testOverview() {
        let movie = mappedMovie()
        expect(movie.overview).to(contain("a young caveman struggles"))
    }
    
    func testGenres() {
        let movie = mappedMovie()
        expect(movie.genres).to(equal("Adventure, Drama"))
    }
    
    func testReleaseDateAsText() {
        let movie = mappedMovie()
        expect(movie.releaseDateAsText()).to(contain("Aug 17, 2018"))
    }
}
