//
//  EpisodeTableViewCell.swift
//  NetworkingProgectTest
//
//  Created by Светлана Сенаторова on 17.04.2023.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var regionLabel: UILabel!
    @IBOutlet var coatOfArmsLabel: UILabel!
    @IBOutlet var wordsLabel: UILabel!
    @IBOutlet var titlesLabel: UILabel!
    @IBOutlet var seatsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with episode: Episode) {
        nameLabel.text = episode.name
        regionLabel.text = episode.region
        coatOfArmsLabel.text = episode.coatOfArms
        wordsLabel.text = episode.words
        titlesLabel.text = episode.titles?.joined(separator: ", ")
        seatsLabel.text = episode.seats?.joined(separator: ", ")
    }

}
