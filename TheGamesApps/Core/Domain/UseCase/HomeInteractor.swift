//
//  HomeInteractor.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import Foundation
import Combine

protocol HomeUseCase {

  func getGenres() -> AnyPublisher<[GenreModel], Error>
    func getGames(search: String) -> AnyPublisher<[GameModel], Error>

}

class HomeInteractor: HomeUseCase {

  private let repository: GameRepositoryProtocol
  
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getGenres() -> AnyPublisher<[GenreModel], Error> {
    return repository.getGenre()
  }
    
    func getGames(search: String) -> AnyPublisher<[GameModel], Error> {
      return repository.getGames(search: search)
    }

}
