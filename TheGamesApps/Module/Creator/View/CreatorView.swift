//
//  CreatorView.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import SwiftUI

struct CreatorView: View {
    @ObservedObject var presenter: CreatorPresenter
    
    var body: some View {
        VStack(alignment: .leading) {
            if presenter.isLoading {
              loadingIndicatorList
            } else if presenter.isError {
              errorIndicator
            } else if presenter.creators.isEmpty {
              emptyList
            } else {
              contentCreator
            }
        }.onAppear {
            if self.presenter.creators.count == 0 {
              self.presenter.getCreators()
            }
            
        }
    }
}

extension CreatorView {
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
        List(self.presenter.creators) { creator in
            self.presenter.linkBuilders(for: creator.id, type: "creator") {
                CreatorRow(creator: creator)
            }
            .navigationBarBackButtonHidden(false)
            .buttonStyle(PlainButtonStyle())
        }
        .listStyle(PlainListStyle())
    }
  }
