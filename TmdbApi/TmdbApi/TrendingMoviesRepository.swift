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
        if let urlResponse = response as? HTTPURLResponse {
            if urlResponse.statusCode == 400 {
                throw TmdbError.badURL
            } else if urlResponse.statusCode == 401 {
                throw TmdbError.unauthorized
            } else if urlResponse.statusCode == 404 {
                throw TmdbError.notFound
            }
            print(urlResponse.statusCode)
        }
    }
}
