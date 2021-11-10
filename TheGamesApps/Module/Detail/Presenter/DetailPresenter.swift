//
//  DetailPresenter.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {

  private var cancellables: Set<AnyCancellable> = []
  private let detailUseCase: DetailUseCase

  @Published var game: GameModel!
  @Published var detail: DetailModel
  @Published var screenshot: [ScreenShootModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false

    init(detailUseCase: DetailUseCase) {
     self.detailUseCase = detailUseCase
     self.game = detailUseCase.getGame()
      self.detail = DetailModel(id: 0, name: "", nameOriginal: "", gameDetailDescription: "", released: "", backgroundImage: "", descriptionRaw: "")
    }

  func getDetail() {
    isLoading = true
    detailUseCase.getDetail()
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
        }, receiveValue: { detail in
          self.detail = detail
        })
        .store(in: &cancellables)
  }
    
    func getGames() {
      isLoading = true
      detailUseCase.getGames()
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
    
    func getScreenShot() {
      isLoading = true
      detailUseCase.getScreenShot()
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
          }, receiveValue: { screen in
            self.screenshot = screen
          })
          .store(in: &cancellables)
    }

  func updateFavoriteGame() {
    detailUseCase.updateFavoriteGame()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { game in
        print(game)
          self.game = game
        })
        .store(in: &cancellables)
  }

}
