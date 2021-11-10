//
//  FavoriteView.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter
    
    var body: some View {
        VStack(alignment: .leading) {
            if presenter.isLoading {
              loadingIndicatorList
            } else if presenter.isError {
              errorIndicator
            } else if presenter.games.isEmpty {
              emptyList
            } else {
              contentCreator
            }
        }.onAppear {
           
                self.presenter.getFavoriteGames()
            
        }
    }
}

extension FavoriteView {
    var loadingIndicatorList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(0...10, id: \.self) { _ in
                    Rectangle()
                        .fill()
                        .frame(height: 200)
                        .cornerRadius(20)
                        .foregroundColor(Color.black.opacity(0.30))
                        .shimmer(isActive: true, speed: 0.15, angle: .init(degrees: 70))
                        .padding(.horizontal)
                        .padding(.top)
                }
            }
            
        }
    }
  
  var errorIndicator: some View {
    VStack {
         Text(presenter.errorMessage)
    }.offset(y: 80)
  }

    var emptyList: some View {
        VStack(alignment: .center) {
           Text("Tidak Ada Data")
      }.offset(y: 80)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

    var contentCreator: some View {
        List(self.presenter.games) { games in
            self.presenter.linkBuilder(for: games) {
                FavoriteRow(game: games)
            }.buttonStyle(PlainButtonStyle())
            
        }
        .listStyle(PlainListStyle())
    }
  }
