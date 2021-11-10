//
//  GenresResponse.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation

struct GenresResponse: Codable {
    let count: Int
    let results: [GenreResponse]
}

struct GenreResponse: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
