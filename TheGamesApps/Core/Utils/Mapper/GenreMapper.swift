//
//  GenreMapper.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

final class GenreMapper {
    static func mapGenreResponsesToDomains(
      input genreResponse: [GenreResponse]
    ) -> [GenreModel] {
      return genreResponse.map { result in
        let showGenre =  GenreModel(
          id: result.id,
          name: result.name,
          slug: result.slug,
          gamesCount: result.gamesCount,
          imageBackground: result.imageBackground
        )
        return showGenre
      }
    }
}
