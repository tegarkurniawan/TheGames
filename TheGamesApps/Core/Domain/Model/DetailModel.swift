//
//  DetailModel.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation

struct DetailModel: Equatable, Identifiable {
    var id: Int
    var name, nameOriginal, gameDetailDescription: String
    var released: String
    var backgroundImage: String
    var descriptionRaw: String
}
