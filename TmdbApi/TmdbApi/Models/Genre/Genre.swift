//
//  Genre.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 13.08.24.
//

import Foundation

/// Official genre for the movie from **[TMDB API](https://developer.themoviedb.org/reference/genre-movie-list)**.
///
/// Genre is a category of creative work, based on some stylistic criteria.
///
/// A movie can fit into multiple genres.
struct Genre: Codable {
    /// Unique identifier for a genre.
    let id: Int
    /// Official name of the genre.
    let name: String
}
