//
//  HomeViewModel.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 07.08.24.
//

import SwiftUI
import Observation
import TmdbApi

@Observable
class HomeViewModel {
    var trendingMovies: [MovieOverview]
    var error: String?
    private let repository: TrendingMoviesRepository
    
    init(repository: TrendingMoviesRepository) {
        self.repository = repository
        trendingMovies = []
    }
    
    func fetchMovies() async {
        do {
            trendingMovies = try await fetchTrendingMovies()
        } catch {
            self.error = error.localizedDescription
            print(error.localizedDescription)
        }
    }
    
    private func fetchTrendingMovies() async throws -> [MovieOverview] {
        return try await repository.fetchTrending()
    }
}
