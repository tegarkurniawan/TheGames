//
//  CustomTabBar.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: String
    @Binding var selectedName: String
    @Binding var selection: Int?
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(image: "house", selectedTab: $selectedTab, selectedName: $selectedName, selection: $selection)
            TabBarButton(image: "heart", selectedTab: $selectedTab, selectedName: $selectedName, selection: $selection)
            TabBarButton(image: "person.3.fill", selectedTab: $selectedTab, selectedName: $selectedName, selection: $selection)
            TabBarButton(image: "person", selectedTab: $selectedTab, selectedName: $selectedName, selection: $selection)
        }
        .padding()
        .background(Color(hex: 0xf5352ED))
        .cornerRadius(30)
        .padding(.horizontal)
    }
}

struct TabBarButton: View {
    var image: String
    @Binding var selectedTab: String
    @Binding var selectedName: String
    @Binding var selection: Int?
    var body: some View {
        GeometryReader {reader in
           
            Button(action: {
                withAnimation {
                    selectedTab = image
                    if image == "house"{
                        selection = 0
                        selectedName = "Games"
                    } else if image == "heart" {
                        selection = 1
                        selectedName = "Favorite"
                    } else if image == "person.3.fill" {
                        selection = 2
                        selectedName = "Creator"
                    } else if image == "person" {
                        selection = 3
                        selectedName = "About"
                    }
                        
                }
            }, label: {
                Image(systemName: image)
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(.white)
                    .offset(y: selectedTab == image ? -10 : 0)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                           
        }
        .frame(height: 40)
    }
}
