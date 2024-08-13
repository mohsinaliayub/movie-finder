//
//  InMemoryTrendingMoviesRepository.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 13.08.24.
//

import Foundation
import TmdbApi

class InMemoryTrendingMoviesRepository: TrendingMoviesRepository {
    var currentPage: Int = 1
    
    var hasMoreData: Bool { currentPage < 2 }
    
    func fetchTrending() async throws -> [MovieOverview] {
        let url = Bundle.main.url(forResource: "trending-movies-page-1", withExtension: "json")
        guard let url else { return [] }
        
        return try await decode(url: url)
    }
    
    func fetchNextPage() async throws -> [MovieOverview] {
        guard hasMoreData else { return [] }
        
        let url = Bundle.main.url(forResource: "trending-movies-page-2", withExtension: "json")
        guard let url else { return [] }
        
        currentPage = 2
        return try await decode(url: url)
    }
    
    private func decode(url: URL) async throws -> [MovieOverview] {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let movies = try JSONDecoder().decode([MovieOverview].self, from: data)
        return movies
    }
}
