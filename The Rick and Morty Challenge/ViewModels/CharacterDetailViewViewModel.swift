//
//  CharacterDetailViewViewModel.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 23/09/24.
//

import Foundation

final class CharacterDetailViewViewModel {
    
    private let character: RMCharacterResults
    
    init(character: RMCharacterResults) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
