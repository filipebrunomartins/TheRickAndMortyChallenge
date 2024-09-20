//
//  DetailViewController.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 11/09/24.
//
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    var character: RMCharacterResults?
    
    override func viewDidLoad() {
        testLabel.text = character?.name
    }
    
}
