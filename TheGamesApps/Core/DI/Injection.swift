//
//  Injection.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
  private func provideRepository() -> GameRepositoryProtocol {
    let realm = try? Realm()

    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return GameRepository.sharedInstance(locale, remote)
  }

  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }

  func provideCreator() -> CreatorUseCase {
    let repository = provideRepository()
    return CreatorInteractor(repository: repository)
  }

  func provideFavorite() -> FavoriteUseCase {
    let repository = provideRepository()
    return FavoriteInteractor(repository: repository)
  }
    func provideDetail(game: GameModel) -> DetailUseCase {
      let repository = provideRepository()
      return DetailInteractor(repository: repository, game: game)
    }
    func provideGames(id: Int) -> GamesUseCase {
      let repository = provideRepository()
      return GamesInteractor(repository: repository, id: id)
    }

}
