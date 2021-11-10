//
//  GameModel.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation

struct GameModel: Equatable, Identifiable {
    var id: String
    var name, released: String
    var backgroundImage: String
    var rating: String
    var favorite: Bool = false
}
