//
//  GamesResponse.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation

struct GamesResponse: Decodable {
    let count: Int
    let next: String
    let results: [GameResponse]

    enum CodingKeys: String, CodingKey {
        case count, next, results
    }
    
}

struct GameResponse: Decodable {
    let id: String
    let name, released: String
    let backgroundImage: String?
    let rating: String

    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating
    }

}

extension GameResponse {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = String(try values.decode(Int.self, forKey: .id))
        let name = try values.decode(String.self, forKey: .name)
        let released = try values.decode(String.self, forKey: .released)
        let backgroundImage = try values.decode(String?.self, forKey: .backgroundImage)
        let rating = String(try values.decode(Double.self, forKey: .rating))
        
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
    }
}

extension Double {
    func toString() -> String {
        return String(format: "%.1f", self)
    }
}
