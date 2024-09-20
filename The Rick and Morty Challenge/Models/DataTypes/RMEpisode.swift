//
//  RMEpisode.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 19/08/24.
//

import Foundation
	

struct RMEpisode: Codable {
    let info: RMInfo
    let results: Array<RMEpisodeResults>
}

struct RMEpisodeResults: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: Array<String>
    let url: String
    let created: String
}
