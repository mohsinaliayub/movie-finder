//
//  MovieOverview.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 12.08.24.
//

import Foundation

/// Brief information for the movie.
public struct MovieOverview {
    /// A unique identifier for a movie.
    ///
    /// Use this identifier later to find the details for the movie.
    public let id: Int
    /// The original release title for the movie.
    public let title: String
    /// The URL for the official movie poster.
    public let posterPath: URL?
    /// Short plot of movie.
    public let synopsis: String
    /// IMDB rating for the movie.
    public let rating: Double
    /// Official release date of the movie.
    public let releaseDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, title, synopsis = "overview", rating = "vote_average"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}

extension MovieOverview: Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        synopsis = try container.decode(String.self, forKey: .synopsis)
        rating = try container.decode(Double.self, forKey: .rating)
        if let stringDate = try? container.decode(String.self, forKey: .releaseDate) {
            releaseDate = DateFormatter.tmdbDateFormatter.date(from: stringDate)
        } else {
            releaseDate = nil
        }
        if let posterPathString = try? container.decode(String.self, forKey: .posterPath) {
            posterPath = URL(string: Constants.ApiConstants.baseURLForPoster + posterPathString)
        } else {
            posterPath = nil
        }
    }
}

extension MovieOverview: Equatable, Hashable {}
