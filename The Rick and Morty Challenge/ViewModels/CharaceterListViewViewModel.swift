//
//  CharaceterListViewViewModel.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 20/09/24.
//

import UIKit

protocol CharaceterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
}

final class CharaceterListViewViewModel: NSObject {
    
    public weak var delegate: CharaceterListViewViewModelDelegate?
    
    private var characters: Array<RMCharacterResults> = [] {
        didSet  {
            for character in characters {
                let viewModel = CharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [CharacterCollectionViewCellViewModel] = []
    
    public func fetchCharacceters(){
        Service.shared.execute(
            .listCharactersRequest,
            expexting: GetAllCharactersResponse.self
        ){ [weak self] result in
            switch result {
            case .success(let success):
                let results = success.results
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
}

extension CharaceterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? CharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
}
