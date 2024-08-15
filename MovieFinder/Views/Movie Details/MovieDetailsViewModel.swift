//
//  MovieDetailsViewModel.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 14.08.24.
//

import Foundation
import TmdbApi
import Observation

@Observable
class MovieDetailsViewModel {
    @ObservationIgnored
    private let movieId: Int
    @ObservationIgnored
    private let repository: MovieDetailsRepository
    private(set) var movie: Movie?
    
    init(movieId: Int, repository: MovieDetailsRepository) {
        self.movieId = movieId
        self.repository = repository
    }
    
    func fetchMovieDetails() async {
        do {
//            try await Task.sleep(nanoseconds: 4000)
            movie = try await repository.fetchMovie(by: movieId)
            print(movie ?? "NO MOVIE")
        } catch {
            print(error.localizedDescription)
        }
    }
}
