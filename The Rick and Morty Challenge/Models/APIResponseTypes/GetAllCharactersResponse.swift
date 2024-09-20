//
//  GetAllCharactersResponse.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 20/09/24.
//

import Foundation

struct GetAllCharactersResponse: Codable {
    let info: RMInfo
    let results: Array<RMCharacterResults>
}
