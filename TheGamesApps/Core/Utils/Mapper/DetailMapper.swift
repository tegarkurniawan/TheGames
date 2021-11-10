//
//  DetailMapper.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

final class DetailMapper {
    
    static func mapDetailResponsesToDomains(
      input detail: DetailsResponse
    ) -> DetailModel {
        let showDetail =  DetailModel(id: detail.id, name: detail.name, nameOriginal: detail.nameOriginal, gameDetailDescription: detail.gameDetailDescription, released: detail.released, backgroundImage: detail.backgroundImage, descriptionRaw: detail.descriptionRaw
        )
        return showDetail
    }
}
