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
    private let repository = TrendingMoviesRepository()
    
    init() {
        trendingMovies = []
    }
    
    func fetchMovies() async {
        do {
            trendingMovies = try await fetchTrendingMovies()
            print(trendingMovies.count)
        } catch {
            self.error = error.localizedDescription
            print(error.localizedDescription)
        }
    }
    
    private func fetchTrendingMovies() async throws -> [MovieOverview] {
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/week?api_key=\(Constants.ApiConstants.apiKey)")
        return try await repository.fetchMovies(from: url)
    }
}
