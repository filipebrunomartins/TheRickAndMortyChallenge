//
//  RMLocation.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 19/08/24.
//

import Foundation


struct RMLocation: Codable {
    let info: RMInfo
    let results: Array<RMLocationResults>
}

struct RMLocationResults: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: Array<String>
    let url: String
    let created: String
}
