//
//  MoviesListViewModel.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 13.08.24.
//

import Foundation
import TmdbApi
import Observation

@Observable
class MoviesListViewModel {
    let repository: TrendingMoviesRepository
    private(set) var movies: [MovieOverview]
    
    init(repository: TrendingMoviesRepository) {
        self.repository = repository
        movies = []
    }
    
    func fetchMovies() async throws {
        movies += try await repository.fetchTrending()
    }
    
    func fetchNextPage() async throws {
        
    }
}
