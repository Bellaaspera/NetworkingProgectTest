//
//  OneCharacterViewController.swift
//  NetworkingProgectTest
//
//  Created by Светлана Сенаторова on 14.04.2023.
//

import UIKit

class OneCharacterViewController: UIViewController {

    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var idTextField: UITextField!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var cultureLabel: UILabel!
    @IBOutlet var dateOfBirthLabel: UILabel!
    @IBOutlet var dateOfDeathLabel: UILabel!
    @IBOutlet var titlesLabel: UILabel!
    @IBOutlet var aliasesLabel: UILabel!
    @IBOutlet var tvSeriesLabel: UILabel!
    @IBOutlet var playedByLabel: UILabel!
    @IBOutlet var allegiancesLabel: UILabel!
    
    var singleCharacter: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        fetchRandomCharacterInfo()
        characterImage.image = UIImage(systemName: "person")
//        nameLabel.text = "name: \(singleCharacter?.name ?? "No data")"
//        genderLabel.text = "gender: \(singleCharacter?.gender ?? "No data")"
//        cultureLabel.text = "culture: \(singleCharacter?.culture ?? "No data")"
//        dateOfBirthLabel.text = "date of birth: \(singleCharacter?.born ?? "No data")"
//        dateOfDeathLabel.text = "date of death: \(singleCharacter?.died ?? "No data")"
//        titlesLabel.text = "titles: \(singleCharacter?.titles?.joined() ?? "No data")"
//        aliasesLabel.text = "aliases: \(singleCharacter?.aliases?.joined(separator: ", ") ?? "No data")"
//        tvSeriesLabel.text = "TV series: \(singleCharacter?.tvSeries?.joined(separator: ", ") ?? "No data")"
//        playedByLabel.text = "played by: \(singleCharacter?.playedBy?.joined(separator: ", ") ?? "No data")"
//        allegiancesLabel.text = "allegiances: \(singleCharacter?.allegiances?.joined(separator: ", ") ?? "No data")"
    }

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}

// MARK: - Networking

extension OneCharacterViewController {
    
   func fetchRandomCharacterInfo() {
        guard let url = URL(string: "https://anapioficeandfire.com/api/characters/583") else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let character = try JSONDecoder().decode(Character.self, from: data)
                self?.singleCharacter = character
                DispatchQueue.main.async {
                    self?.nameLabel.text = "name: \(character.name ?? "No data")"
                    self?.genderLabel.text = "gender: \(character.gender ?? "No data")"
                    self?.cultureLabel.text = "culture: \(character.culture ?? "No data")"
                    self?.dateOfBirthLabel.text = "date of birth: \(character.born ?? "No data")"
                    self?.dateOfDeathLabel.text = "date of death: \(character.died ?? "No data")"
                    self?.titlesLabel.text = "titles: \(character.titles?.joined(separator: ", ") ?? "No data")"
                    self?.aliasesLabel.text = "aliases: \(character.aliases?.joined(separator: ", ") ?? "No data")"
                    self?.tvSeriesLabel.text = "TV series: \(character.tvSeries?.joined(separator: ", ") ?? "No data")"
                    self?.playedByLabel.text = "played by: \(character.playedBy?.joined(separator: ", ") ?? "No data")"
                    self?.allegiancesLabel.text = "allegiances: \(character.allegiances?.joined(separator: ", ") ?? "No data")"
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
        
    }

}

extension OneCharacterViewController: UITextFieldDelegate {
    
}
