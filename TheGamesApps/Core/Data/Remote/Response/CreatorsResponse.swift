//
//  CreatorsResponse.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation

struct CreatorsResponse: Codable {
    let results: [CreatorResponse]
}

struct CreatorResponse: Codable {
    let id: Int
    let name: String
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageBackground = "image_background"
    }
}
