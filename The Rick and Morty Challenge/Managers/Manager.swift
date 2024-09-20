//
//  Manager.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 04/09/24.
//

import Foundation

class Manager {
    
    func loadCharacter() async throws -> Array<RMCharacterResults>  {
        
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let characterResponse = try decoder.decode(GetAllCharactersResponse.self, from: data)
            return characterResponse.results
        } catch {
            throw ManagerError.defaultError
        }

    }
    
}

enum ManagerError: Error {
    case defaultError
    case decodeError
}
