//
//  CharaceterListViewViewModel.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 20/09/24.
//

import UIKit

protocol CharaceterListViewViewModelProtocol: AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
}

final class CharaceterListViewViewModel: NSObject {
    
    public weak var delegate: CharaceterListViewViewModelProtocol?
    
    var isLoadingMoreCharacters = false
    
    var characters: Array<RMCharacterResults> = [] {
        didSet {
            for character in characters {
                let viewModel = CharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                if !cellViewModels.contains(viewModel){
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    var cellViewModels: [CharacterCollectionViewCellViewModel] = []
    
    var apiInfo: RMInfo? = nil
    
    // Fetch initial (20) Characters
    public func fetchCharacceters(){
        Service.shared.execute(
            .listCharactersRequest,
            expexting: GetAllCharactersResponse.self
        ){ [weak self] result in
            switch result {
            case .success(let success):
                let results = success.results
                let info = success.info
                self?.characters = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    // Paginação adiciona mais characters
    public func fetchAdditionalCharacters() {
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        guard let urlString = apiInfo?.next,
              let url = URL(string: urlString),
              let request = Request(url: url) else {
            isLoadingMoreCharacters = false
            return
        }
        
        Service.shared.execute(
            request,
            expexting: GetAllCharactersResponse.self
        ) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case.success(let success):
                let moreResults = success.results
                let info = success.info
                strongSelf.apiInfo = info
                
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                let total = originalCount+newCount
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(
                        row: $0,
                        section: 0
                    )
                })
                strongSelf.characters.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(
                        with: indexPathsToAdd
                    )
                    strongSelf.isLoadingMoreCharacters = false
                }
            case.failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreCharacters = false
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
}
