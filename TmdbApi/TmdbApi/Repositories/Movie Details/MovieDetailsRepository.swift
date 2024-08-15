//
//  MovieDetailsRepository.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 14.08.24.
//

import Foundation

public protocol MovieDetailsRepository {
    func fetchMovie(by movieId: Int) async throws -> Movie
}
