//
//  HomeViewModel.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 07.08.24.
//

import SwiftUI
import Observation

@Observable
class HomeViewModel {
    var trendingMovies: [MovieOverview]
    var error: String?
    
    init() {
        trendingMovies = []
    }
    
    func fetchMovies() async {
        do {
            trendingMovies = try await fetchTrendingMovies()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func fetchTrendingMovies() async throws -> [MovieOverview] {
        let urlString = "https://api.themoviedb.org/3/trending/movie/week?api_key=\(Constants.ApiConstants.apiKey)"
        guard let url = URL(string: urlString) else { throw TMDBError.url }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw TMDBError.notFound }
        
        let result = try JSONDecoder().decode(MovieOverviewResult.self, from: data)
        return result.movies
    }
}
