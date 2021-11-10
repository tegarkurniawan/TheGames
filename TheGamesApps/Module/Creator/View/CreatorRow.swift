//
//  CreatorRow.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CreatorRow: View {
    
    var creator: CreatorModel
    var body: some View {
        ZStack {
            WebImage(url: URL(string: creator.imageBackground))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10.0)
                .overlay(Text(creator.name)
                            .foregroundColor(Color(hex: 0xf5352ED))
                            .fontWeight(.bold)
                            .font(.largeTitle), alignment: .center)
        }
    }
}
