//
//  HomeView.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        ScrollView {
        VStack(alignment: .leading) {
            SearchBar(text: $presenter.title,
                      onSearchButtonClicked: presenter.getGames
            )
            VStack(alignment: .leading) {
               Text("Genre")
                    .font(.title3)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                if presenter.isLoadingGenre {
                  loadingIndicator
                } else if presenter.isErrorGenre {
                  errorIndicator
                } else if presenter.genres.isEmpty {
                  emptyList
                } else {
                  content
                }
            }
            .padding()
            .background(Color(hex: 0xf5352ED))
            .cornerRadius(10)
            .padding()
            
            VStack(alignment: .leading) {
               Text("Platform")
                    .font(.title3)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                if presenter.isLoadingGenre {
                  loadingIndicator
                } else if presenter.isErrorGenre {
                  errorIndicator
                } else if presenter.genres.isEmpty {
                  emptyList
                } else {
                  content
                }
            }
            .padding()

            
            Text("List Games")
                
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(.black)
                .padding()
            
            if presenter.isLoading {
              loadingIndicatorList
            } else if presenter.isError {
              errorIndicator
            } else if presenter.genres.isEmpty {
              emptyList
            } else {
              contentGames
            }
          }
        }.onAppear {
            if self.presenter.genres.count == 0 {
              self.presenter.getGenres()
            }
            if self.presenter.games.count == 0 {
              self.presenter.getGames()
            }
        }
    }
}

extension HomeView {
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
  var loadingIndicator: some View {
      HStack {
          ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 15) {
                 
                      ForEach(0...5, id: \.self) {_ in
                          Rectangle()
                              .fill()
                              .frame(width: 150, height: 70)
                              .cornerRadius(20)
                              .foregroundColor(Color.black.opacity(0.30))
                              .shimmer(isActive: true, speed: 0.15, angle: .init(degrees: 70))
                          
                      }
              }
          }
          .frame(height: 70)
      }
  }

  var errorIndicator: some View {
    VStack {
         Text(presenter.errorMessage)
    }.offset(y: 80)
  }

    var emptyList: some View {
      VStack {
           Text("Tidak Ada Data")
      }.offset(y: 80)
  }

    var contentGames: some View {
        ForEach(self.presenter.games) { game in
            self.presenter.linkBuilder(for: game) {
                GameRow(game: game)
            }.buttonStyle(PlainButtonStyle())
            
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .listStyle(PlainListStyle())
    }

  var content: some View {
      HStack {
          ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 15) {
                 
                  ForEach(self.presenter.genres) { genre in
                      self.presenter.linkBuilders(for: genre.id, type: "genre") {
                          GenreRow(genre: genre)
                      }
                      .navigationBarBackButtonHidden(false)
                      .buttonStyle(PlainButtonStyle())
                      
                  }
              }
              
          }
          .frame(height: 70)
          
      }
  }

}
