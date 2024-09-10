//
//  ViewModel.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 04/09/24.
//

import Foundation

class ViewModel {
    
    var manager: Manager
    var characters: Array<RMCharacterResults> = []
    
    init(manager: Manager) {
        self.manager = manager
    }
    
    func loadCharacters() async {
            do {
                self.characters = try await manager.loadCharacter()
                // Atualize a UI ou faça qualquer outra coisa necessária
            } catch {
                print("Error fetching characters:", error)
            }
    }
}
