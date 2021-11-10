//
//  RemoteDataSource.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {

  func getGames(search: String) -> AnyPublisher<[GameResponse], Error>
  func getCreatorGames(by id: String) -> AnyPublisher<[GameResponse], Error>
  func getGenreGames(by id: String) -> AnyPublisher<[GameResponse], Error>
  func getScreenShoots(by id: String) -> AnyPublisher<[ScreenShotResponse], Error>
  func getGenre() -> AnyPublisher<[GenreResponse], Error>
  func getCreator() -> AnyPublisher<[CreatorResponse], Error>
  func getDetail(by id: String) -> AnyPublisher<DetailsResponse, Error>

}

final class RemoteDataSource: NSObject {

  private override init() { }

  static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {
   
    func getCreatorGames(
      by id: String
    ) -> AnyPublisher<[GameResponse], Error> {
      return Future<[GameResponse], Error> { completion in
          let queryItems = [
            URLQueryItem(name: "developers", value: id),
            URLQueryItem(name: "key", value: self.apiKey)
          ]
          var components = URLComponents(string: Endpoints.Gets.games.url)

          components?.queryItems = queryItems
          
          if let url = components?.url {
          AF.request(url)
            .validate()
            .responseDecodable(of: GamesResponse.self) { response in
              switch response.result {
              case .success(let value):
                  completion(.success(value.results))
              case .failure:
                completion(.failure(URLError.invalidResponse))
              }
            }
        }
      }.eraseToAnyPublisher()
    }
    
    func getGenreGames(
      by id: String
    ) -> AnyPublisher<[GameResponse], Error> {
      return Future<[GameResponse], Error> { completion in
          let queryItems = [
              URLQueryItem(name: "genres", value: id),
              URLQueryItem(name: "key", value: self.apiKey)
          ]
          var components = URLComponents(string: Endpoints.Gets.games.url)

          components?.queryItems = queryItems
          
          if let url = components?.url {
          AF.request(url)
            .validate()
            .responseDecodable(of: GamesResponse.self) { response in
              switch response.result {
              case .success(let value):
                  completion(.success(value.results))
              case .failure:
                completion(.failure(URLError.invalidResponse))
              }
            }
        }
      }.eraseToAnyPublisher()
    }

    func getDetail(
      by id: String
    ) -> AnyPublisher<DetailsResponse, Error> {
      return Future<DetailsResponse, Error> { completion in
          let queryItems = [
              URLQueryItem(name: "key", value: self.apiKey)
          ]
          var components = URLComponents(string: Endpoints.Gets.games.url+"/\(id)")

          components?.queryItems = queryItems
          if let url = components?.url {
             
          AF.request(url)
            .validate()
            .responseDecodable(of: DetailsResponse.self) { response in
              switch response.result {
              case .success(let value):
                  completion(.success(value))
              case .failure:
                 
                completion(.failure(URLError.invalidResponse))
              }
            }
        }
      }.eraseToAnyPublisher()
    }
    
    private var apiKey: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
        }
        return value
      }
    }
    func getScreenShoots(by id: String) -> AnyPublisher<[ScreenShotResponse], Error> {
        return Future<[ScreenShotResponse], Error> { completion in
            let queryItems = [
                URLQueryItem(name: "key", value: self.apiKey)
            ]
            var components = URLComponents(string: Endpoints.Gets.games.url+"/\(id)/screenshots")

            components?.queryItems = queryItems
            if let url = components?.url {
            AF.request(url)
              .validate()
              .responseDecodable(of: ScreenShotsResponse.self) { response in
                  
                switch response.result {
                case .success(let value):
                    completion(.success(value.results))
                case .failure:
                  completion(.failure(URLError.invalidResponse))
                }
              }
          }
        }.eraseToAnyPublisher()
    }
    
    func getGenre() -> AnyPublisher<[GenreResponse], Error> {
        return Future<[GenreResponse], Error> { completion in
            let queryItems = [
                URLQueryItem(name: "key", value: self.apiKey)
            ]
            var components = URLComponents(string: Endpoints.Gets.genres.url)

            components?.queryItems = queryItems
            if let url = components?.url {
            AF.request(url)
              .validate()
              .responseDecodable(of: GenresResponse.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value.results))
                case .failure:
                  completion(.failure(URLError.invalidResponse))
                }
              }
          }
        }.eraseToAnyPublisher()
    }
    
    func getCreator() -> AnyPublisher<[CreatorResponse], Error> {
        return Future<[CreatorResponse], Error> { completion in
            let queryItems = [
                URLQueryItem(name: "key", value: self.apiKey)
            ]
            var components = URLComponents(string: Endpoints.Gets.creators.url)

            components?.queryItems = queryItems
            if let url = components?.url {
            AF.request(url)
              .validate()
              .responseDecodable(of: CreatorsResponse.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value.results))
                case .failure:
                  completion(.failure(URLError.invalidResponse))
                }
              }
          }
        }.eraseToAnyPublisher()
    }
  
      func getGames(
        search: String
      ) -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in
            let queryItems = [
                URLQueryItem(name: "search", value: search),
                URLQueryItem(name: "key", value: self.apiKey)
            ]
            var components = URLComponents(string: Endpoints.Gets.games.url)

            components?.queryItems = queryItems
            
            if let url = components?.url {
            AF.request(url)
              .validate()
              .responseDecodable(of: GamesResponse.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value.results))
                case .failure:
                  completion(.failure(URLError.invalidResponse))
                }
              }
          }
        }.eraseToAnyPublisher()
      }

}
