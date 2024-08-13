//
//  MovieDetailRepository.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 13.08.24.
//

import Foundation
import TmdbApi

class InMemoryMovieDetailRepository: MovieDetailsRepository {
    private let movieId = 533535
    
    func fetchMovie(by id: Int) async throws -> Movie {
        guard id == movieId else { throw TmdbError.notFound }
        
        guard let url else { throw TmdbError.invalidURL }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode(Movie.self, from: data)
    }
    
    private var url: URL? {
        Bundle.main.url(forResource: "movie-details", withExtension: "json")
    }
}
