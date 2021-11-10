//
//  HomePresenter.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {

  private var cancellables: Set<AnyCancellable> = []
  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase

  @Published var genres: [GenreModel] = []
  @Published var games: [GameModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false
  @Published var errorMessageGenre: String = ""
  @Published var isLoadingGenre: Bool = false
  @Published var isErrorGenre: Bool = false
    
  var title = ""
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func getGenres() {
    isLoadingGenre = true
    homeUseCase.getGenres()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessageGenre = error.localizedDescription
          self.isErrorGenre = true
          self.isLoadingGenre = false
        case .finished:
          self.isLoadingGenre = false
        }
      }, receiveValue: { genres in
        self.genres = genres
      })
      .store(in: &cancellables)
  }
    
    func getGames() {
      isLoading = true
      homeUseCase.getGames(search: title)
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
        }, receiveValue: { games in
          self.games = games
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
    
    func linkBuilders<Content: View>(
      for id: Int,
      type: String,
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(
        destination: router.makeGamesView(for: id, type: type)) { content() }
       
    }
}
