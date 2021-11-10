//
//  LocaleDataSourceProtocol.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {

  func getFavoriteGame() -> AnyPublisher<[GameEntity], Error>
  func updateFavoriteGame(by id: String, from game: GameEntity) -> AnyPublisher<GameEntity, Error>
  func getGameById(by id: String, from game: GameEntity) -> AnyPublisher<GameEntity, Error>

}

final class LocaleDataSource: NSObject {

  private let realm: Realm?

  private init(realm: Realm?) {
    self.realm = realm
  }

  static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
    return LocaleDataSource(realm: realmDatabase)
  }

}

extension LocaleDataSource: LocaleDataSourceProtocol {
   
    func getFavoriteGame() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
          if let realm = self.realm {
            let gameEntities = {
              realm.objects(GameEntity.self)
                .filter("favorite = \(true)")
                .sorted(byKeyPath: "id", ascending: true)
            }()
            completion(.success(gameEntities.toArray(ofType: GameEntity.self)))
          } else {
            completion(.failure(DatabaseError.invalidInstance))
          }
        }.eraseToAnyPublisher()
    }
    
    func updateFavoriteGame(by id: String, from game: GameEntity) -> AnyPublisher<GameEntity, Error> {
        return Future<GameEntity, Error> { completion in
            if let realm = self.realm {
              do {
                try realm.write {
                  
                    if let gameEntity = realm.object(ofType: GameEntity.self, forPrimaryKey: game.id) {
                        realm.delete(gameEntity)
                        game.favorite = false
                        completion(.success(game))
                    } else {
                        game.favorite = true
                        realm.add(game)
                        completion(.success(game))
                    }
                  
                }
                
              } catch {
                completion(.failure(DatabaseError.requestFailed))
              }
            } else {
              completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getGameById(by id: String, from game: GameEntity) -> AnyPublisher<GameEntity, Error> {
        return Future<GameEntity, Error> { completion in
                
            if let realm = self.realm {
              do {
                try realm.write {
                  
                    if let gameEntity = realm.object(ofType: GameEntity.self, forPrimaryKey: game.id) {
                        gameEntity.favorite = true
                        completion(.success(gameEntity))
                    } else {
                      
                        completion(.success(game))
                    }
                  
                }
                
              } catch {
                completion(.failure(DatabaseError.requestFailed))
              }
            } else {
              completion(.failure(DatabaseError.invalidInstance))
            }

        }.eraseToAnyPublisher()
    }
    
}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
