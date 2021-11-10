//
//  GameRepository.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation
import Combine

protocol GameRepositoryProtocol {
  
  func getGames(search: String) -> AnyPublisher<[GameModel], Error>
  func getCreatorGames(by id: String) -> AnyPublisher<[GameModel], Error>
  func getGenreGames(by id: String) -> AnyPublisher<[GameModel], Error>
  func getScreenShots(by id: String) -> AnyPublisher<[ScreenShootModel], Error>
  func getGenre() -> AnyPublisher<[GenreModel], Error>
  func getCreator() -> AnyPublisher<[CreatorModel], Error>
  func getFavoriteGames() -> AnyPublisher<[GameModel], Error>
    func updateFavoriteGames(by id: String, from game: GameModel) -> AnyPublisher<GameModel, Error>
  func getDetail(id: String) -> AnyPublisher<DetailModel, Error>
    func getGame(id: String, from game: GameModel) -> AnyPublisher<GameModel, Error>
}

final class GameRepository: NSObject {
  
  typealias GameInstance = (LocaleDataSource, RemoteDataSource) -> GameRepository
  
  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource
  
  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }
  
  static let sharedInstance: GameInstance = { localeRepo, remoteRepo in
    return GameRepository(locale: localeRepo, remote: remoteRepo)
  }
  
}

extension GameRepository: GameRepositoryProtocol {
    func getCreatorGames(by id: String) -> AnyPublisher<[GameModel], Error> {
        return self.remote.getCreatorGames(by: id)
            .map { GameMapper.mapGameResponsesToDomains(input: $0) }
          .eraseToAnyPublisher()
    }
    
    func getGenreGames(by id: String) -> AnyPublisher<[GameModel], Error> {
        return self.remote.getGenreGames(by: id)
            .map { GameMapper.mapGameResponsesToDomains(input: $0) }
          .eraseToAnyPublisher()
    }
    
    func getGame(id: String, from game: GameModel) -> AnyPublisher<GameModel, Error> {
        let a: GameEntity = GameMapper.mapDetailGameModelToEntity(input: game)
        return self.locale.getGameById(by: game.id, from: a)
            .map { GameMapper.mapDetailGameEntityToDomain(input: $0) }
          .eraseToAnyPublisher()
    }
    
    func getDetail(id: String) -> AnyPublisher<DetailModel, Error> {
        return self.remote.getDetail(by: id)
            .map { DetailMapper.mapDetailResponsesToDomains(input: $0) }
          .eraseToAnyPublisher()
    }
    
    func getFavoriteGames() -> AnyPublisher<[GameModel], Error> {
        return self.locale.getFavoriteGame()
            .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
          .eraseToAnyPublisher()
    }
    
    func updateFavoriteGames(by id: String, from game: GameModel) -> AnyPublisher<GameModel, Error> {
        print("Update Favorite")
        let a: GameEntity = GameMapper.mapDetailGameModelToEntity(input: game)
        return self.locale.updateFavoriteGame(by: id, from: a)
            .map { GameMapper.mapDetailGameEntityToDomain(input: $0) }
          .eraseToAnyPublisher()
    }
    
    func getGames(search: String) -> AnyPublisher<[GameModel], Error> {
        return self.remote.getGames(search: search)
            .map { GameMapper.mapGameResponsesToDomains(input: $0) }
          .eraseToAnyPublisher()
    }
    
    func getScreenShots(by id: String) -> AnyPublisher<[ScreenShootModel], Error> {
        return self.remote.getScreenShoots(by: id)
            .map { ScreenShotMapper.mapScreenShotResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }

    func getGenre() -> AnyPublisher<[GenreModel], Error> {
        return self.remote.getGenre()
            .map { GenreMapper.mapGenreResponsesToDomains(input: $0)}
            .eraseToAnyPublisher()
    }

    func getCreator() -> AnyPublisher<[CreatorModel], Error> {
        return self.remote.getCreator()
            .map { CreatorMapper.mapCreatorResponsesToDomains(input: $0)}
            .eraseToAnyPublisher()
    }

}
