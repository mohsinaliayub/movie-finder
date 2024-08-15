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
    
    var indices: Range<Int> { movies.indices }
    private var loadingData = false
    private let thresholdForNextPage = 2
    
    init(repository: TrendingMoviesRepository) {
        self.repository = repository
        movies = []
    }
    
    func fetchMovie(at index: Int) -> MovieOverview {
        if (index + thresholdForNextPage) >= movies.count {
            Task {
                try? await fetchNextPage()
            }
        }
        
        return movies[index]
    }
    
    func fetchMovies() async throws {
        guard !loadingData else { return }
        
        loadingData = true
        movies = try await repository.fetchTrending()
        loadingData = false
    }
    
    func fetchNextPage() async throws {
        guard !loadingData else { return }
        loadingData = true
        let newMovies = try await repository.fetchNextPage()
        newMovies.forEach { movies.append($0) }
        
        loadingData = false
    }
}
