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
    case unknown
    
    static func error(from httpResponse: HTTPURLResponse) -> Self {
        switch httpResponse.statusCode {
        case 400: return .badURL
        case 401: return .unauthorized
        case 404: return .notFound
        default: return .unknown
        }
    }
}
