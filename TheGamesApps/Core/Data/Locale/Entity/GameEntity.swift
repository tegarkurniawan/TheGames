//
//  GameEntity.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation
import RealmSwift

class GameEntity: Object {

  @objc dynamic var id = ""
  @objc dynamic var name = ""
  @objc dynamic var released = ""
  @objc dynamic var rating = ""
  @objc dynamic var backgroundImage = ""
  @objc dynamic var favorite = false

  override static func primaryKey() -> String? {
    return "id"
  }
}
