//
//  GameMapper.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 01/11/21.
//

final class GameMapper {
    
    static func mapGameResponsesToDomains(
      input gameResponse: [GameResponse]
    ) -> [GameModel] {
      return gameResponse.map { result in
        let showGame =  GameModel(
          id: result.id,
          name: result.name,
          released: result.released,
          backgroundImage: result.backgroundImage ?? "a",
          rating: result.rating
        )
        return showGame
      }
    }
    static func mapGameEntitiesToDomains(
      input gameEntities: [GameEntity]
    ) -> [GameModel] {
      return gameEntities.map { result in
        return GameModel(
            id: result.id,
            name: result.name,
            released: result.released,
            backgroundImage: result.backgroundImage,
            rating: result.rating,
            favorite: result.favorite
        )
      }
    }
    
    static func mapDetailGameEntityToDomain(
      input gameEntity: GameEntity
    ) -> GameModel {
     
        return GameModel(
            id: gameEntity.id,
            name: gameEntity.name,
            released: gameEntity.released,
            backgroundImage: gameEntity.backgroundImage,
            rating: gameEntity.rating,
            favorite: gameEntity.favorite
        )
    }
    
    static func mapDetailGameModelToEntity(
      input gameModel: GameModel
    ) -> GameEntity {
     
        let gameEntity = GameEntity()
        gameEntity.id = gameModel.id
        gameEntity.name = gameModel.name
        gameEntity.released = gameModel.released
        gameEntity.backgroundImage = gameModel.backgroundImage
        gameEntity.rating = gameModel.rating
        gameEntity.favorite = gameModel.favorite
        return gameEntity
    }
}
