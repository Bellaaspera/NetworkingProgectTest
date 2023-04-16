//
//  TableViewCell.swift
//  NetworkingProgectTest
//
//  Created by Светлана Сенаторова on 14.04.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var characterImage: UIImageView! {
        didSet {
            characterImage.layer.cornerRadius = 20
        }
    }
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var familyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func configure(with characters: Characters) {
        nameLabel.text = characters.fullName
        titleLabel.text = characters.title
        familyLabel.text = characters.family
        
        guard let url = URL(string: characters.imageUrl ?? "") else { return }
        DispatchQueue.global().async { [weak self] in
            
            guard let imageData = try? Data(contentsOf: url) else {
                self?.characterImage.image = UIImage(systemName: "person")
                return
            }
            DispatchQueue.main.async {
                self?.characterImage.image = UIImage(data: imageData)
            }
        }
    }

}

