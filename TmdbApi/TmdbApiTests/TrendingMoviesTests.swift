//
//  TrendingMoviesTests.swift
//  TmdbApiTests
//
//  Created by Mohsin Ali Ayub on 10.08.24.
//

import XCTest
@testable import TmdbApi

// TODO: - Improve the code: try not to use do-catch

final class TrendingMoviesTests: XCTestCase {
    var sut: TrendingMoviesRepository!
    
    override func setUp() async throws {
        sut = TrendingMoviesRepository()
    }
    
    override func tearDown() async throws {
        sut = nil
    }
    
    func test_fetchTrending_withNilUrl_throwsInvalidUrlError() async {
        do {
            try await sut.fetchMovies(from: nil)
        } catch {
            XCTAssertEqual(error as! TmdbError, TmdbError.invalidURL)
        }
    }
    
    func test_fetchTrending_providedApiKey_withMalformedUrl_throwsBadUrlError() async {
        let url = URL(string: "https://api.themoviedb.org/3/trending/ovie/week?api_key=\(Common.ApiConstants.apiKey)")
        
        do {
            try await sut.fetchMovies(from: url)
            XCTFail("Malformed URL does not throw Bad URL error")
        } catch {
            XCTAssertEqual(error as! TmdbError, .badURL)
        }
    }
    
    func test_fetchTrending_providedApiKey_withNonExistentUrl_throwsNotFoundError() async {
        let url = URL(string: "https://api.themoviedb.org/3/trendings/movie/week?api_key=\(Common.ApiConstants.apiKey)")
        
        do {
            try await sut.fetchMovies(from: url)
            XCTFail("Non-existent URL does not throw Bad URL error")
        } catch {
            XCTAssertEqual(error as! TmdbError, .notFound)
        }
    }
    
    func test_fetchTrending_withoutApiKey_throwsUnauthorizedError() async {
        let url = URL(string: "https://api.themoviedb.org/3/trendings/movie/week")
        
        do {
            try await sut.fetchMovies(from: url)
            XCTFail("Unauthorized request did not fail")
        } catch {
            XCTAssertEqual(error as! TmdbError, .unauthorized)
        }
    }
    
}
