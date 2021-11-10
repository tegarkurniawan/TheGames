//
//  ScreenShootModel.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation

struct ScreenShootModel: Equatable, Identifiable {
    var id: Int
    var image: String
    var width, height: Int
    var isDeleted: Bool
}
