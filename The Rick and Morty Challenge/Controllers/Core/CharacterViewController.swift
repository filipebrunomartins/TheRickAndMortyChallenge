//
//  CharacterViewController.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 19/09/24.
//

import UIKit

/*
 Função comunicar entre class
 lifecycle da view
 Logicas da view
 */
final class CharacterViewController: UIViewController {
    
    lazy var customView = CharacterListView(
        cvDataSource: self,
        cvDelegate: self
    )
    var viewModel: CharaceterListViewViewModel!
    
    /*
     Função para carregar componentes
     Função para declarar dependencias da view (ex: delegate)
     */
    override func loadView() {
        super.loadView()
        self.view = customView
    }

    /*
     Todos os componentes da view já carragaram
     função utilizada para carregar dados
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        viewModel.delegate = self
        viewModel.fetchCharacceters()
    }
}

extension CharacterViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.isLoadingMoreCharacters {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.viewModel.fetchAdditionalCharacters()
            }
            t.invalidate()
        }
    }
}

/*
    MARK: - Character List View Model Delegate
 delegate que controla funções:
    -carregar characters iniciais
    -carregar mais characters
 */
extension CharacterViewController: CharaceterListViewViewModelProtocol {
    func didLoadInitialCharacters() {
        customView.spinner.stopAnimating()
        customView.colletionView.isHidden = false
        customView.colletionView.reloadData() //Initial fetch
        UIView.animate(withDuration: 0.4, animations: {
            self.customView.colletionView.alpha = 1
        })
    }
    
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath]) {
        customView.colletionView.performBatchUpdates {
            self.customView.colletionView.insertItems(at: newIndexPaths)
        }
    }
}

/*
    MARK: - Character List View UICollectionView
 extensão que controla funções da collectionView
 */
extension CharacterViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? CharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: viewModel.cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FooterLoadingCollectionReusableView.identifier,
                for: indexPath
              ) as? FooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        
        return footer
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        guard viewModel.shouldShowLoadMoreIndicator else {
            return .zero
        }
        
        return CGSize(
            width: collectionView.frame.width,
            height: 100
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let bounds = collectionView.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = viewModel.characters[indexPath.row]
        
        let viewModel = CharacterDetailViewViewModel(character: character)
        let detailVC = CharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
