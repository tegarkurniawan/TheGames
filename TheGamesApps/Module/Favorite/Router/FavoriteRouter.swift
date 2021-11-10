//
//  FavoriteRouter.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import SwiftUI

class FavoriteRouter {

  func makeDetailView(for game: GameModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(game: game)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
  
}
