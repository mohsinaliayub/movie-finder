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
    private var trendingMovies: [MovieOverview]
    var indices: [Int] { Array(trendingMovies.indices) }
    var error: String?
    private let repository: TrendingMoviesRepository
    // Use this property as a threshold to load more data...
    private let thresholdForNextPage = 2
    private var loadingNextPage = false
    
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
    
    func getMovie(at index: Int) -> MovieOverview {
        // When we have reached the threshold, load more data (i.e. next page of results)
        if (index + thresholdForNextPage) >= trendingMovies.count && !loadingNextPage {
            print("Reached the threshold: loading more data...")
            loadingNextPage = true
            Task {
                await fetchNextPage()
                print("Data loaded...")
                loadingNextPage = false
            }
        }
        
        return trendingMovies[index]
    }
    
    func fetchNextPage() async {
        guard repository.hasMoreData else { return }
        
        do {
            trendingMovies += try await repository.fetchNextPage()
        } catch {
            self.error = error.localizedDescription
            print(error.localizedDescription)
        }
    }
    
    private func fetchTrendingMovies() async throws -> [MovieOverview] {
        return try await repository.fetchTrending()
    }
}
