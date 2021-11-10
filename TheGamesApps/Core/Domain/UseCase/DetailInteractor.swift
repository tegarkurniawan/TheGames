//
//  DetailInteractor.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import Foundation
import Combine

protocol DetailUseCase {

  func getGame() -> GameModel
  func getGames() -> AnyPublisher<GameModel, Error>
  func getScreenShot() -> AnyPublisher<[ScreenShootModel], Error>
  func getDetail() -> AnyPublisher<DetailModel, Error>
  func updateFavoriteGame() -> AnyPublisher<GameModel, Error>

}

class DetailInteractor: DetailUseCase {
    
  private let repository: GameRepositoryProtocol
  private let game: GameModel

  required init(
    repository: GameRepositoryProtocol,
    game: GameModel
  ) {
    self.repository = repository
    self.game = game
  }

  func getGame() -> GameModel {
    return game
  }
  
  func getGames() -> AnyPublisher<GameModel, Error> {
      return repository.getGame(id: game.id, from: game)
  }

  func getScreenShot() -> AnyPublisher<[ScreenShootModel], Error> {
    return repository.getScreenShots(by: game.id)
  }
    
  func getDetail() -> AnyPublisher<DetailModel, Error> {
      return repository.getDetail(id: String(game.id))
  }
    
  func updateFavoriteGame() -> AnyPublisher<GameModel, Error> {
      return repository.updateFavoriteGames(by: game.id, from: game)
  }
    
}
