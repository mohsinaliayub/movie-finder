//
//  TrendingMoviesRepository.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 12.08.24.
//

import Foundation

/// Repository for trending movies.
public protocol TrendingMoviesRepository {
    /// The current page of data.
    var currentPage: Int { get }
    
    /// There are more page results available to load.
    ///
    /// If `true`, use ``fetchNextPage()`` to load more data.
    var hasMoreData: Bool { get }
    
    /// Fetch the weekly trending movies.
    ///
    /// Loads the first page of results. If you want the nextPage of results, use ``fetchNextPage()``.
    func fetchTrending() async throws -> [MovieOverview]
    
    /// Fetches the next page of results for weekly trending movies.
    ///
    /// Only loads the next page of results, if available.
    func fetchNextPage() async throws -> [MovieOverview]
}
