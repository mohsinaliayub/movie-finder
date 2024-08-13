//
//  MovieDetailsTests.swift
//  TmdbApiTests
//
//  Created by Mohsin Ali Ayub on 13.08.24.
//

import XCTest
@testable import TmdbApi

final class MovieDetailsTests: XCTestCase {
    
    var sut: TmdbMovieDetailsRepository!
    let movieId = 533535
    
    override func setUp() {
        sut = TmdbMovieDetailsRepository()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_wrongMovieID_throwsNotFound() async {
        let movieId = -1
        do {
            _ = try await sut.fetchMovie(by: movieId)
            XCTFail("The request should fail with wrong movie id")
        } catch {
            XCTAssertEqual(error as! TmdbError, .notFound)
        }
    }
    
    func test_withMovieID_returnsProperMovie() async {
        do {
            let movie = try await sut.fetchMovie(by: movieId)
            XCTAssertEqual(movie.id, movieId)
        } catch {
            XCTFail("The request should not fail for proper movie")
        }
    }
    
    func test_withMovieId_decodesIntoMovieObject() async {
        do {
            let movie = try await sut.fetchMovie(by: movieId)
            XCTAssertFalse(movie.title.isEmpty)
            XCTAssertFalse(movie.synopsis.isEmpty)
            XCTAssertFalse(movie.genres.isEmpty)
        } catch {
            XCTFail("The request should not fail for proper movie id.")
        }
    }
}
