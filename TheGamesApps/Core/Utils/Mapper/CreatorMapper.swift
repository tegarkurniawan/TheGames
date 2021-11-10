//
//  CreatorMapper.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

final class CreatorMapper {
    
    static func mapCreatorResponsesToDomains(
      input creatorResponse: [CreatorResponse]
    ) -> [CreatorModel] {
      return creatorResponse.map { result in
        let showCreator =  CreatorModel(
          id: result.id,
          name: result.name,
          imageBackground: result.imageBackground
        )
        return showCreator
      }
    }
}
