//
//  APICall.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation

struct API {

  static let baseUrl = "https://api.rawg.io/api/"

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {
  
  enum Gets: Endpoint {
    case games
    case genres
    case creators
    
    public var url: String {
      switch self {
      case .games: return "\(API.baseUrl)games"
      case .genres: return "\(API.baseUrl)genres"
      case .creators: return "\(API.baseUrl)developers"
      
      }
    }
  }
  
}
