//
//  Cast.swift
//  TmdbApi
//
//  Created by Mohsin Ali Ayub on 14.08.24.
//

import Foundation

/// A cast member of a movie.
///
/// A cast member is a person who did some sort of work on the movie.
/// The work can be acting, voice or even a behind the scenes work.
struct Cast {
    /// Unique id of the cast member.
    let id: Int
    /// Original name of the cast member.
    let name: String
    /// Character portrayed by the cast member.
    ///
    /// If multiple characters are portrayed by the person, they will be separated by '/'.
    let character: String
    /// The order of appearance in the movie.
    let order: Int
    /// The credit identifier of the cast member.
    ///
    /// You can use this to get more details about the credit work.
    let creditId: String
    /// The photo URL of the cast member.
    let profilePhotoURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id, name, character, order
        case creditId = "credit_id"
        case profilePhotoURL = "profile_path"
    }
}

extension Cast: Decodable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        character = try container.decode(String.self, forKey: .character)
        order = try container.decode(Int.self, forKey: .order)
        creditId = try container.decode(String.self, forKey: .creditId)
        if let photoURLString = try? container.decode(String.self, forKey: .profilePhotoURL) {
            profilePhotoURL = URL(string: Constants.ApiConstants.baseURLForPoster + photoURLString)
        } else {
            profilePhotoURL = nil
        }
    }
}

enum CastDepartment: String, Codable {
    case acting = "Acting"
    case crew = "Crew"
}
