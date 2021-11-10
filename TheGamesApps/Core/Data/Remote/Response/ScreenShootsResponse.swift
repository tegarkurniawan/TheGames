//
//  ScreenShootsResponse.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation

struct ScreenShotsResponse: Codable {
    let count: Int
    let results: [ScreenShotResponse]
}

struct ScreenShotResponse: Codable {
    let id: Int
    let image: String
    let width, height: Int
    let isDeleted: Bool

    enum CodingKeys: String, CodingKey {
        case id, image, width, height
        case isDeleted = "is_deleted"
    }
}
