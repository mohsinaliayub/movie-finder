//
//  TmdbTrendingMoviesTests.swift
//  TmdbApiTests
//
//  Created by Mohsin Ali Ayub on 10.08.24.
//

import XCTest
@testable import TmdbApi

// TODO: - Improve the code: try not to use do-catch

final class TmdbTrendingMoviesTests: XCTestCase {
    var sut: TmdbTrendingMovies!
    
    override func setUp() async throws {
        sut = TmdbTrendingMovies()
    }
    
    override func tearDown() async throws {
        sut = nil
    }
    
    func test_fetchTrending_withNilUrl_throwsInvalidUrlError() async {
        sut.url = nil
        
        do {
            _ = try await sut.fetchTrending()
        } catch {
            XCTAssertEqual(error as! TmdbError, TmdbError.invalidURL)
        }
    }
    
    func test_fetchTrending_providedApiKey_withMalformedUrl_throwsBadUrlError() async {
        sut.url = URL(string: "https://api.themoviedb.org/3/trending/ovie/week?api_key=\(Constants.ApiConstants.apiKey)")
        
        do {
            _ = try await sut.fetchTrending()
            XCTFail("Malformed URL does not throw Bad URL error")
        } catch {
            XCTAssertEqual(error as! TmdbError, .badURL)
        }
    }
    
    func test_fetchTrending_providedApiKey_withNonExistentUrl_throwsNotFoundError() async {
        sut.url = URL(string: "https://api.themoviedb.org/3/trendings/movie/week?api_key=\(Constants.ApiConstants.apiKey)")
        
        do {
            _ = try await sut.fetchTrending()
            XCTFail("Non-existent URL does not throw Bad URL error")
        } catch {
            XCTAssertEqual(error as! TmdbError, .notFound)
        }
    }
    
    func test_fetchTrending_withoutApiKey_throwsUnauthorizedError() async {
        sut.url = URL(string: "https://api.themoviedb.org/3/trendings/movie/week")
        
        do {
            _ = try await sut.fetchTrending()
            XCTFail("Unauthorized request did not fail")
        } catch {
            XCTAssertEqual(error as! TmdbError, .unauthorized)
        }
    }
    
    func test_fetchTrending_withInvalidApiKey_throwsUnauthorizedError() async {
        let invalidApiKey = "4934209803428304823"
        sut.url = URL(string: "https://api.themoviedb.org/3/trendings/movie/week?api_key=\(invalidApiKey)")
        
        do {
            _ = try await sut.fetchTrending()
            XCTFail("Unauthorized request did not fail")
        } catch {
            XCTAssertEqual(error as! TmdbError, .unauthorized)
        }
    }
    
    // FIXME: Internet access not taken into account - Use mocks
    func test_fetchTrending_withSuccessfulRequest_returnsMovieOverviews() async {
        sut.url = trendingMoviesURL()
        
        do {
            let movies = try await sut.fetchTrending()
            XCTAssertEqual(movies.count, 20) // a page returns 20 results
        } catch {
            XCTFail("Request (with proper URL and API Key) should have succedded")
        }
    }
    
    func test_fetchTrending_withSuccessfulRequest_hasAtleastOneMovieOverview() async {
        sut.url = trendingMoviesURL()
        
        do {
            let movies = try await sut.fetchTrending()
            XCTAssertNotNil(movies.first?.id)
            XCTAssertNotNil(movies.first?.title)
        } catch {
            XCTFail("Request (with proper URL and API Key) should have succedded")
        }
    }
    
    func test_fetchNextPage_withSuccessfulRequest_returnsNewResults() async {
        do {
            var movies = try await sut.fetchTrending() // returns first 20 results
            movies += try await sut.fetchNextPage() // returns next 20 results
            XCTAssertEqual(movies.count, 40)
        } catch {
            XCTFail("Request (with proper URL and API Key) should have returned the next page")
        }
    }
    
    // MARK: - Helper Methods
    private func trendingMoviesURL() -> URL? {
        URL(string: "https://api.themoviedb.org/3/trending/movie/week?api_key=\(Constants.ApiConstants.apiKey)")
    }
    
    private func trendingMoviesURLWithPage(_ page: Int = 2) -> URL? {
        var components = URLComponents(string: "https://api.themoviedb.org/3/trending/movie/week")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.ApiConstants.apiKey),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        return components?.url
    }
}
