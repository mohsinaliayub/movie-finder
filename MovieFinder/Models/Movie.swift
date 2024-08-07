//
//  Movie.swift
//  MovieFinder
//
//  Created by Mohsin Ali Ayub on 02.08.24.
//

import Foundation

/// Describes a movie from [TMDB API](https://developer.themoviedb.org/reference/genre-movie-list).
struct Movie {
    /// A unique identifier for a movie.
    let id: Int
    /// The original title of the movie.
    let title: String
    /// A brief description of the movie's plot.
    let overview: String
    /// The URL of the official movie poster.
    let posterPath: URL?
    /// The URL of the official movie backdrop.
    let backdropPath: URL?
    /// The IMDB rating of the movie.
    let rating: Double
    /// An array of genres.
    let genres: [Genre]
}

struct MovieOverview: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, posterPath = "poster_path"
    }
}

struct MovieOverviewResult: Codable {
    let page: Int
    let movies: [MovieOverview]
    
    enum CodingKeys: String, CodingKey {
        case page, movies = "results"
    }
}
