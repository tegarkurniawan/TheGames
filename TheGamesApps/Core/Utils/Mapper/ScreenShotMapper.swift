//
//  ScreenShotMapper.swift
//  TheGamesApps
//
//  Created by tegar kurniawan on 02/11/21.
//

final class ScreenShotMapper {
    
    static func mapScreenShotResponsesToDomains(
      input screenResponse: [ScreenShotResponse]
    ) -> [ScreenShootModel] {
      return screenResponse.map { result in
        let showScreen =  ScreenShootModel(
          id: result.id,
          image: result.image,
          width: result.width,
          height: result.height,
          isDeleted: result.isDeleted
        )
        return showScreen
      }
    }
}
