//
//  TrendingMoviesRepository.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 10.08.24.
//

import Foundation

class TrendingMoviesRepository {
    private let session = URLSession.shared
    
    func fetchMovies(from url: URL?) async throws {
        guard let url else { throw TmdbError.invalidURL }
        
        let (data, response) = try await session.data(from: url)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw TmdbError.error(from: httpResponse)
        }
    }
}
