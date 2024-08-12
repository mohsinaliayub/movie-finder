//
//  TmdbTrendingMovies.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 10.08.24.
//

import Foundation

public class TmdbTrendingMovies {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func fetchMovies(from url: URL?) async throws -> [MovieOverview] {
        guard let url else { throw TmdbError.invalidURL }
        
        let (data, response) = try await session.data(from: url)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw TmdbError.error(from: httpResponse)
        }
        
        // request is successful, deserialize data
        let moviesResult = try JSONDecoder().decode(MovieOverviewResult.self, from: data)
        return moviesResult.movies
    }
}
