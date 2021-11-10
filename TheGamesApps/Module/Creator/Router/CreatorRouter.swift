//
//  CreatorRouter.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//
import SwiftUI

class CreatorRouter {
    
    func makeGamesView(for id: Int, type: String) -> some View {
      let gamesUseCase = Injection.init().provideGames(id: id)
      let presenter = GamesPresenter(gamesUseCase: gamesUseCase, id: id)
     return GamesView(presenter: presenter, type: type)
    }
  
}
