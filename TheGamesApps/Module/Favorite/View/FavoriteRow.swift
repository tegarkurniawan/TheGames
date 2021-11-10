//
//  FavoriteRow.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteRow: View {
    var game: GameModel
    var body: some View {
        VStack {
            WebImage(url: URL(string: game.backgroundImage))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10.0)
         
                    HStack {
                        VStack(alignment: .leading) {
                           
                            Text(game.name)
                                .font(.title3)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                                .frame(maxWidth: 200, alignment: .leading)
                                .lineLimit(3)
                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.white)
                                Text(game.released)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                            
                        }
                        
                        .layoutPriority(100)
         
                        Spacer()
                        HStack {
                            Image(systemName: "star")
                                .foregroundColor(.yellow)
                            Text(game.rating)
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                }
                .background(Color(hex: 0xf5352ED))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                )
    }
}
