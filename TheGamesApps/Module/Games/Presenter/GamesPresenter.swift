//
//  GamesPresenter.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import SwiftUI
import Combine

class GamesPresenter: ObservableObject {

  private var cancellables: Set<AnyCancellable> = []
  private let router = GamesRouter()
  private let gamesUseCase: GamesUseCase

  @Published var game: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var id: Int
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false
    
  var search = ""
  
    init(gamesUseCase: GamesUseCase, id: Int) {
    self.gamesUseCase = gamesUseCase
    self.id = id
  }
  
  func getCreatorGames() {
    isLoading = true
    gamesUseCase.getCreatorGames()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { game in
        self.game = game
      })
      .store(in: &cancellables)
  }
    
  func getGenreGames() {
      isLoading = true
      gamesUseCase.getGenreGames()
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            self.errorMessage = error.localizedDescription
            self.isError = true
            self.isLoading = false
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { game in
          self.game = game
        })
        .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
      for game: GameModel,
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(
        destination: router.makeDetailView(for: game)) { content() }
        
    }
}
