//
//  DetailsResponse.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation

struct DetailsResponse: Codable {
    let id: Int
    let name, nameOriginal, gameDetailDescription: String
    let released: String
    let backgroundImage: String
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameOriginal = "name_original"
        case gameDetailDescription = "description"
        case released
        case backgroundImage = "background_image"
        case descriptionRaw = "description_raw"
    }
}
