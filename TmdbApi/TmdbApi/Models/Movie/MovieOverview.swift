//
//  MovieOverview.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 12.08.24.
//

import Foundation

public struct MovieOverview {
    public let id: Int
    public let title: String
    public let posterPath: URL?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
    }
}

extension MovieOverview: Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        if let posterPathString = try? container.decode(String.self, forKey: .posterPath) {
            posterPath = URL(string: Constants.ApiConstants.baseURLForPoster + posterPathString)
        } else {
            posterPath = nil
        }
    }
}
