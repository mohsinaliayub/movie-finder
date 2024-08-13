//
//  Credits.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 14.08.24.
//

import Foundation

/// The credits of a movie.
///
/// An array of cast members who did some kind of work in the movie.
struct Credits {
    /// A list of people who acted in the movie.
    let cast: [Cast]
}

extension Credits: Decodable { }
