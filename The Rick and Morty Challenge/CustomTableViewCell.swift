//
//  CustomTableViewCell.swift
//  The Rick and Morty Challenge
//
//  Created by Filipe Icarros on 17/08/24.
//

import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!{
        didSet {
            nameLbl.font = UIFont(name: "Rick-and-morty-font.ttf", size: 18)
        }
    }
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var originBtn: UIButton!
    @IBOutlet weak var locationBtn: UIButton!
    
    @IBAction func originBtnClick(){
        
    }
    
    @IBAction func locationBtnClick(){
        
    }
    
    func prepareView(_ character: RMCharacterResults){
        let url = URL(string: character.image)
        imageCharacter.kf.setImage(with: url)
        nameLbl.text = character.name
        originBtn.setTitle(character.origin.name, for: .normal)
        locationBtn.setTitle(character.location.name, for: .normal)
    }
    
}
