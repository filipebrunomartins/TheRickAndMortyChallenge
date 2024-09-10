//
//  RMCharacter.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 19/08/24.
//

import Foundation

struct RMCharacter: Codable {
    let info: RMCharacterInfo
    let results: Array<RMCharacterResults>
}

struct RMCharacterInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
}

struct RMCharacterResults: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: RMCharacterResultsOrigin
    let location: RMCharacterResultsLocation
    let image: String
    let episode: Array<String>
    let url: String
    let created: String
}

struct RMCharacterResultsOrigin: Codable {
    let name: String
    let url: String
}

struct RMCharacterResultsLocation: Codable {
    let name: String
    let url: String
}



