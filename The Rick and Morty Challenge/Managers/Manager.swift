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
        
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let characterResponse = try decoder.decode(RMCharacter.self, from: data)
        return characterResponse.results
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            
//            if let error {
//                print("Error while fetching data:", error)
//                return
//            }
//            
//            guard let data else {
//                print("teste","teste")
//                return
//            }
//            // Decodifica o JSON em um objeto `RMCharacter`
//            do {
//                let decoder = JSONDecoder()
//                let characterResponse = try decoder.decode(RMCharacter.self, from: data)
//                print(characterResponse)
//            } catch {
//                print("Error while decoding data:", error)
//            }
//        }
//        task.resume()
    }
    
}
