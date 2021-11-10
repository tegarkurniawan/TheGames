//
//  ContentView.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 28/10/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    @EnvironmentObject var creatorPresenter: CreatorPresenter
    
    @State var selection: Int? = 0
    @State var selectedTab = "house"
    @State var selectedName = "Games"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                    if(selection == 0) {
                        HomeView(presenter: homePresenter)
                    } else if(selection == 1) {
                        FavoriteView(presenter: favoritePresenter)
                    } else if(selection == 2) {
                        CreatorView(presenter: creatorPresenter)
                    } else if(selection == 3) {
                        AboutView()
                    }
                    
                Spacer()
                ZStack(alignment: .bottom, content: {
                    CustomTabBar(selectedTab: $selectedTab,
                                 selectedName: $selectedName, selection: $selection)
                })
                .background(Color.clear)
            }
            .navigationBarTitle(selectedName, displayMode: .inline)
        }
        .navigationBarColor(backgroundColor: hexStringToUIColor(hex: "#5352ED"), titleColor: .white)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
