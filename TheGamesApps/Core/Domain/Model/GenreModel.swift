//
//  GenreModel.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation

struct GenreModel: Equatable, Identifiable {
    var id: Int
    var name, slug: String
    var gamesCount: Int
    var imageBackground: String
}
