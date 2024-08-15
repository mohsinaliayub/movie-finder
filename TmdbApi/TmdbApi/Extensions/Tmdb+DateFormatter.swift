//
//  Tmdb+DateFormatter.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 13.08.24.
//

import Foundation

extension DateFormatter {
    static let tmdbDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
