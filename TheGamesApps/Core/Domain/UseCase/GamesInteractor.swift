//
//  GamesInteractor.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import Foundation
import Combine

protocol GamesUseCase {

  func getCreatorGames() -> AnyPublisher<[GameModel], Error>
  func getGenreGames() -> AnyPublisher<[GameModel], Error>
   
}

class GamesInteractor: GamesUseCase {

  private let repository: GameRepositoryProtocol
    private let id: Int
    required init(repository: GameRepositoryProtocol, id: Int) {
    self.repository = repository
    self.id = id
  }
  
  func getCreatorGames() -> AnyPublisher<[GameModel], Error> {
      return repository.getCreatorGames(by: String(id))
  }
    
    func getGenreGames() -> AnyPublisher<[GameModel], Error> {
        return repository.getGenreGames(by: String(id))
    }

}
