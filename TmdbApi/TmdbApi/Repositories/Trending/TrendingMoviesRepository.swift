//
//  TrendingMoviesRepository.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 12.08.24.
//

import Foundation

public protocol TrendingMoviesRepository {
    func fetchTrending() async throws -> [MovieOverview]
}
