//
//  CreatorPresenter.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import SwiftUI
import Combine

class CreatorPresenter: ObservableObject {

  private var cancellables: Set<AnyCancellable> = []
  private let router = CreatorRouter()
  private let creatorUseCase: CreatorUseCase

  @Published var creators: [CreatorModel] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false
    
  var search = ""
  
  init(creatorUseCase: CreatorUseCase) {
    self.creatorUseCase = creatorUseCase
  }
  
  func getCreators() {
    isLoading = true
    creatorUseCase.getCreators()
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
      }, receiveValue: { creators in
        self.creators = creators
      })
      .store(in: &cancellables)
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
