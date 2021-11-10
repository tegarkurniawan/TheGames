//
//  ScreenshotRow.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

import SwiftUI
import SDWebImageSwiftUI
struct ScreenshotRow: View {
    var screen: ScreenShootModel
    var body: some View {
        ZStack {
           
            WebImage(url: URL(string: screen.image))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10.0)
            
        }
    }
}
