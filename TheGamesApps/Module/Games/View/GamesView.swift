//
//  GamesView.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import SwiftUI

struct GamesView: View {
     @ObservedObject var presenter: GamesPresenter
    var type: String
    @State var isNavigationBarHidden: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var backButton : some View {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack(spacing: 0) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text("Kembali").foregroundColor(.white)
                }
            }
        }
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if presenter.isLoading {
                  loadingIndicatorList
                } else if presenter.isError {
                  errorIndicator
                } else if presenter.game.isEmpty {
                  emptyList
                } else {
                  contentCreator
                }
                
            }
            .navigationBarTitle(type == "genre" ? "Games By Genre" : "Games By Creator")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
           
            .navigationBarColor(backgroundColor: hexStringToUIColor(hex: "#5352ED"), titleColor: .white)
            
        }
        .navigationBarHidden(true)
        .onAppear {
            print("Masuk Boyyy")
            if self.presenter.game.count == 0 {
                if(type == "genre") {
                    self.presenter.getGenreGames()
                } else {
                    self.presenter.getCreatorGames()
                }
            }
        }
        .onDisappear {
            print("Keluar Boyyy")
            self.isNavigationBarHidden = true
        }
    }
    
    func hexStringToUIColor (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension GamesView {
   
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
      VStack {
           Text("Tidak Ada Data")
      }.offset(y: 80)
  }

    var contentCreator: some View {
        List(self.presenter.game) { games in
            self.presenter.linkBuilder(for: games) {
                
                FavoriteRow(game: games)
                    
            }.buttonStyle(PlainButtonStyle())
                
        }
        .listStyle(PlainListStyle())
    }
  }
