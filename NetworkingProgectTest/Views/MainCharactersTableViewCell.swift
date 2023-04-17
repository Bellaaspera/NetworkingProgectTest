//
//  MainCharactersTableViewCell.swift
//  NetworkingProgectTest
//
//  Created by Светлана Сенаторова on 14.04.2023.
//

import UIKit

class MainCharactersTableViewCell: UITableViewCell {
    
    @IBOutlet var characterImage: UIImageView! {
        didSet {
            characterImage.layer.cornerRadius = 20
        }
    }
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var familyLabel: UILabel!
    

    func configure(with characters: Characters) {
        nameLabel.text = characters.fullName
        titleLabel.text = characters.title
        familyLabel.text = characters.family
        
        NetworkManager.shared.fetchImage(from: characters.imageUrl) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }

}

