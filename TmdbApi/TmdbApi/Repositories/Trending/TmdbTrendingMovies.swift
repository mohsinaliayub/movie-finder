//
//  TmdbTrendingMovies.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 10.08.24.
//

import Foundation

public class TmdbTrendingMovies: TrendingMoviesRepository {
    var url: URL?
    private var currentPage: Int
    private let session: URLSession
    
    /// A successful response status code for an HTTP request.
    private let requestSuccessful = 200
    
    public init(session: URLSession = .shared) {
        self.session = session
        self.currentPage = 0
        self.url = baseURLComponents().url
    }
    
    public func fetchTrending() async throws -> [MovieOverview] {
        guard let url else { throw TmdbError.invalidURL }
        
        let (data, response) = try await session.data(from: url)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != requestSuccessful {
            throw TmdbError.error(from: httpResponse)
        }
        
        // request is successful, decode data
        let moviesResult = try JSONDecoder().decode(MovieOverviewResult.self, from: data)
        currentPage = moviesResult.page
        return moviesResult.movies
    }
    
    public func fetchNextPage() async throws -> [MovieOverview] {
        // to fetch the next page, we need to add "page" query item
        var components = baseURLComponents()
        components.addQueryItem(name: "page", value: "\(currentPage+1)")
        
        self.url = baseURLComponents().url
        
        return try await fetchTrending()
    }
    
    // MARK: Helper methods
    
    private func baseURLComponents() -> URLComponents {
        var components = URLComponents(string: "https://api.themoviedb.org/3/trending/movie/week")!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.ApiConstants.apiKey)
        ]
        
        return components
    }
}


extension URLComponents {
    mutating func addQueryItem(name: String, value: String) {
        queryItems?.append(URLQueryItem(name: name, value: value))
    }
}
