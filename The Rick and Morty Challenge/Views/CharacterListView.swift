//
//  CharacterListView.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 20/09/24.
//

import UIKit

// View que mostra a lista de Characters (load, error)
final class CharacterListView: UIView {
    
    private let viewModel = CharaceterListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let colletionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            CharacterCollectionViewCell.self,
            forCellWithReuseIdentifier: CharacterCollectionViewCell.cellIdentifier
        )
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(colletionView, spinner)
        
        addConstraints()
        
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacceters()
        setUpColletionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            colletionView.topAnchor.constraint(equalTo: topAnchor),
            colletionView.leftAnchor.constraint(equalTo: leftAnchor),
            colletionView.rightAnchor.constraint(equalTo: rightAnchor),
            colletionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpColletionView() {
        colletionView.dataSource = viewModel
        colletionView.delegate = viewModel
    }
}

extension CharacterListView: CharaceterListViewViewModelDelegate {
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        colletionView.isHidden = false
        colletionView.reloadData() //Initial fetch
        UIView.animate(withDuration: 0.4, animations: {
            self.colletionView.alpha = 1
        })
    }
}
