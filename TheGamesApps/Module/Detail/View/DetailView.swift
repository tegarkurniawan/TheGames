//
//  DetailView.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import SwiftUI
import SDWebImageSwiftUI
struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            
            ScrollView {
                
                if presenter.isLoading {
                  imageDetail
                        .frame(height: 500)
                  loadingDesc
                        .overlay(
                            VStack {
                            Image(systemName: "heart")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.red)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.white)
                            .border(Color.red, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                            .cornerRadius(10.0)
                            .offset(x: -40, y: -70)
                            .onTapGesture {
                               
                            }, alignment: .topTrailing)
                } else if presenter.isError {
                  errorIndicator
                } else if presenter.screenshot.isEmpty {
                    imageDetail
                        .frame(height: 500)
                    loadingDesc
                } else {
                  imageDetail
                  content
                        
                }
            }
            BackButton(action: {presentationMode.wrappedValue.dismiss()})
                .padding(.leading)
                .padding(.top)
        }
        
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: {presentationMode.wrappedValue.dismiss()}))
        .navigationBarHidden(true)
        .onAppear {
            
            if self.presenter.detail.id == 0 {
              self.presenter.getDetail()
            }
            self.presenter.getGames()
            if self.presenter.screenshot.count == 0 {
                self.presenter.getScreenShot()
            }
        }
    }
    
}

extension DetailView {
    var imageDetail: some View {
        WebImage(url: URL(string: presenter.game.backgroundImage))
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .edgesIgnoringSafeArea(.top)
    }
    var loadingIndicator: some View {
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
    
    var loadingDesc: some View {
        VStack(alignment: .leading) {
           
            Text(presenter.game.name)
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                    Text(presenter.game.released)
                        .font(.caption)
                        .foregroundColor(.black)
                }
                HStack {
                    Image(systemName: "star")
                        .foregroundColor(.yellow)
                    Text(presenter.game.rating)
                        .fontWeight(.medium)
                        .padding(.vertical, 8)
                }
            }
            
            HStack {
                ForEach(0...5, id: \.self) {_ in
                    Rectangle()
                        .fill()
                        .frame(width: 150, height: 70)
                        .cornerRadius(20)
                        .foregroundColor(Color.black.opacity(0.30))
                        .shimmer(isActive: true, speed: 0.15, angle: .init(degrees: 70))
                    
                }
            }
            
            Rectangle()
                .fill()
                .frame(width: 500, height: 350)
                .cornerRadius(20)
                .foregroundColor(Color.black.opacity(0.30))
                .shimmer(isActive: true, speed: 0.15, angle: .init(degrees: 70))
            
        }
        .padding()
        .padding(.top)
        .background(Color.white)
        .cornerRadius(30, corners: [.topLeft, .topRight])
        .offset(x: 0, y: -30.0)
        .overlay(
            VStack {
            Image(systemName: "heart")
                .resizable()
                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(presenter.game.favorite == true ? Color.red : Color.gray)
                
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.white)
            .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .cornerRadius(10.0)
            .offset(x: -40, y: -70)
            .onTapGesture {
                self.presenter.updateFavoriteGame()
                print(presenter.game.favorite)
                presenter.game.favorite = !presenter.game.favorite
            }, alignment: .topTrailing)
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

    var content: some View {
        VStack(alignment: .leading) {
            //                Title
            Text(presenter.game.name)
                .font(.title)
                .fontWeight(.bold)
            HStack {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.black)
                    Text(presenter.game.released)
                        .font(.caption)
                        .foregroundColor(.black)
                }
                HStack {
                    Image(systemName: "star")
                        .foregroundColor(.yellow)
                    Text(presenter.game.rating)
                        .fontWeight(.medium)
                        .padding(.vertical, 8)
                }
            }
            
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {

                        ForEach(presenter.screenshot) { screen in
                            ScreenshotRow(screen: screen)
                        }

                    }

                }
                .frame(height: 130)

            }
            
            AttributedText(presenter.detail.descriptionRaw)
            
        }
        .padding()
        .padding(.top)
        .background(Color.white)
        .cornerRadius(30, corners: [.topLeft, .topRight])
        .offset(x: 0, y: -30.0)
        .overlay(
            VStack {
            Image(systemName: "heart")
                .resizable()
                .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(presenter.game.favorite == true ? Color.red : Color.gray)
                
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.white)
            .border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .cornerRadius(10.0)
            .offset(x: -40, y: -70)
            .onTapGesture {
                self.presenter.updateFavoriteGame()
                print(presenter.game.favorite)
                presenter.game.favorite = !presenter.game.favorite
            }, alignment: .topTrailing)
    }
  }

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct BackButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.black)
                .padding(.all, 12)
                .background(Color.white)
                .cornerRadius(8.0)
        }
    }
}
