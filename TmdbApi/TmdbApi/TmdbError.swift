//
//  TmdbError.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 10.08.24.
//

import Foundation

enum TmdbError: Error {
    case invalidURL
    case badURL
    case notFound
    case unauthorized
}
