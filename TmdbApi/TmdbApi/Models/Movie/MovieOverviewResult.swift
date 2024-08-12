//
//  MovieOverviewResult.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 12.08.24.
//

import Foundation

public struct MovieOverviewResult: Decodable {
    let page: Int
    let movies: [MovieOverview]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, movies = "results", totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
