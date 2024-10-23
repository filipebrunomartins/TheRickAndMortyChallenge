//
//  RMCharacter.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 19/08/24.
//

import Foundation

struct RMInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
}

struct RMCharacterResults: Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: RMCharacterGender
    let origin: RMCharacterResultsOrigin
    let location: RMCharacterResultsLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}

enum RMCharacterGender: String, Codable {
    case male = "Male"
    case famale = "Female"
    case `unknown` = "unknown"
}

struct RMCharacterResultsOrigin: Codable {
    let name: String
    let url: String
}

struct RMCharacterResultsLocation: Codable {
    let name: String
    let url: String
}



