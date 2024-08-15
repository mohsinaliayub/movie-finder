//
//  TmdbMovieDetailsRepository.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 13.08.24.
//

import Foundation

public class TmdbMovieDetailsRepository: MovieDetailsRepository {
    
    private let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func fetchMovie(by movieId: Int) async throws -> Movie {
        guard let url = url(for: movieId) else { throw TmdbError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw TmdbError.error(from: httpResponse)
        }
        
        let movie = try JSONDecoder().decode(Movie.self, from: data)
        return movie
    }
    
    private func url(for movieId: Int) -> URL? {
        var components = URLComponents(string: "https://api.themoviedb.org/3/movie/\(movieId)")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.ApiConstants.apiKey),
            URLQueryItem(name: "append_to_response", value: "credits")
        ]
        
        return components?.url
    }
}
