//
//  AboutView.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        
        VStack(alignment: .center) {
            Image("about").resizable()
                .frame(width: 200, height: 200)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(100)
                .offset(y: 30)
               
            Text("Muahamd Tegar Kurniawan")
                .offset(y: 30)
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            
    }
}
