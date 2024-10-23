//
//  CharacterDetailViewController.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 23/09/24.
//

import UIKit

// Controller de uma unica character
final class CharacterDetailViewController: UIViewController {
    
    private let viewModel: CharacterDetailViewViewModel
    
    init(viewModel: CharacterDetailViewViewModel){
        self.viewModel = viewModel
        super.init(
            nibName: nil,
            bundle: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }

}
