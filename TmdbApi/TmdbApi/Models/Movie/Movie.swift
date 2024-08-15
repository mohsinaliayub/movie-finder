//
//  Movie.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 13.08.24.
//

import Foundation

/// Detailed information for the movie.
///
///
public struct Movie {
    /// A unique identifier for a movie.
    ///
    /// Use this identifier later to find the details for the movie.
    public let id: Int
    /// The original release title for the movie.
    public let title: String
    /// Short plot of movie.
    public let synopsis: String
    /// IMDB rating for the movie.
    public let rating: Double
    /// Official release date of the movie.
    ///
    /// It will be nil if the movie has not been released.
    public let releaseDate: Date?
    /// The URL for the official movie poster.
    public let posterURL: URL?
    /// The URL for the official movie back drop.
    public let backdropURL: URL?
    /// Official list of genres related to the movie.
    public let genres: [Genre]
    /// Cast members who performed acting in the movie.
    ///
    /// It only contains the top 20 people who performed some kind of acting in the movie.
    public let cast: [Cast]
    
    enum CodingKeys: String, CodingKey {
        case id, title, synopsis = "overview"
        case rating = "vote_average", releaseDate = "release_date"
        case posterURL = "poster_path", backdropURL = "backdrop_path"
        case genres, credits
    }
}

extension Movie: Decodable {
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
        
        if let posterPathString = try? container.decode(String.self, forKey: .posterURL) {
            posterURL = URL(string: Constants.ApiConstants.baseURLForPoster + posterPathString)
        } else {
            posterURL = nil
        }
        
        if let backdropPathString = try? container.decode(String.self, forKey: .backdropURL) {
            backdropURL = URL(string: Constants.ApiConstants.baseURLForPoster + backdropPathString)
        } else {
            backdropURL = nil
        }
        
        genres = try container.decode([Genre].self, forKey: .genres)
        let credits = try container.decode(Credits.self, forKey: .credits)
        cast = Array(credits.cast.prefix(20))
    }
}

extension Movie: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(id): \(title) - \(releaseDate != nil ? "released" : "upcoming")"
    }
}
