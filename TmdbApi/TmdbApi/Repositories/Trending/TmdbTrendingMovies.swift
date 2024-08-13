//
//  TmdbTrendingMovies.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 10.08.24.
//

import Foundation

public class TmdbTrendingMovies: TrendingMoviesRepository {
    internal var url: URL?
    
    public private(set) var currentPage: Int
    public var hasMoreData: Bool { currentPage < totalPages }
    
    private let session: URLSession
    // initial value of 1, so the first data access succeeds.
    internal var totalPages = 1
    
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
        totalPages = moviesResult.totalPages
        return moviesResult.movies
    }
    
    public func fetchNextPage() async throws -> [MovieOverview] {
        // if there's no more data, no need to make the api call
        guard hasMoreData else { return [] }
        
        // to fetch the next page, we need to add "page" query item
        var components = baseURLComponents()
        print(components.queryItems?.count ?? "EMPTY ARRAY")
        components.addQueryItem(name: "page", value: "\(currentPage+1)")
        print(components.queryItems?.count ?? "EMPTY ARRAY")
        
        self.url = components.url
        
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
