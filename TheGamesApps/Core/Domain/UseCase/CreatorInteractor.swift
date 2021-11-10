//
//  CreatorInteractor.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import Foundation
import Combine

protocol CreatorUseCase {

  func getCreators() -> AnyPublisher<[CreatorModel], Error>
   
}

class CreatorInteractor: CreatorUseCase {

  private let repository: GameRepositoryProtocol
  
  required init(repository: GameRepositoryProtocol) {
    self.repository = repository
  }
  
  func getCreators() -> AnyPublisher<[CreatorModel], Error> {
      return repository.getCreator()
  }

}
