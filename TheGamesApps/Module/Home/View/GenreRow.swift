//
//  GenreRow.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GenreRow: View {

  var genre: GenreModel
  var body: some View {
    ZStack {
        WebImage(url: URL(string: genre.imageBackground))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10.0)
            .overlay(Text(genre.name).foregroundColor(.white)
                        .font(.title3), alignment: .center)
    }
   
  }

}
