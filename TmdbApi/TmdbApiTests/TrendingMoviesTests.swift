//
//  TrendingMoviesTests.swift
//  TmdbApiTests
//
//  Created by Mohsin Ali Ayub on 10.08.24.
//

import XCTest
@testable import TmdbApi

final class TrendingMoviesTests: XCTestCase {
    
    func test_fetchTrending_withNilUrl_throwsInvalidUrlError() {
        let sut = TrendingMoviesRepository()
        
        XCTAssertThrowsError(try sut.fetchMovies(from: nil)) { error in
            XCTAssertEqual(error as! TmdbError, TmdbError.invalidUrl)
        }
    }
    
    
}
