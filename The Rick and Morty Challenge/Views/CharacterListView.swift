//
//  CharacterListView.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 20/09/24.
//

import UIKit

// View que mostra a lista de Characters (load, error)
final class CharacterListView: RMView {
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let colletionView: UICollectionView = {
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
        collectionView.register(
            FooterLoadingCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: FooterLoadingCollectionReusableView.identifier
        )
        
        return collectionView
    }()
    
    init(
        cvDataSource: UICollectionViewDataSource,
        cvDelegate: UICollectionViewDelegate
    ) {
        super.init(frame: UIScreen.main.bounds)
        self.colletionView.delegate = cvDelegate
        self.colletionView.dataSource = cvDataSource
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func configureAdditionalSettings() {
        self.backgroundColor = .systemBackground
        spinner.startAnimating()
    }
    
    override func addSubviews() {
        addSubviews(colletionView, spinner)
    }
    
    override func addConstraints() {
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
}
