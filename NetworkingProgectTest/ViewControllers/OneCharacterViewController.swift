//
//  OneCharacterViewController.swift
//  NetworkingProgectTest
//
//  Created by Светлана Сенаторова on 14.04.2023.
//

import UIKit

class OneCharacterViewController: UIViewController {

    @IBOutlet var characterImage: UIImageView! {
        didSet {
            characterImage.layer.cornerRadius = 20
        }
    }
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
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
    
    private var singleCharacter: Character?
    private var allCharacters: [Characters]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchSingleCharacterInfo()
    }

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}

// MARK: - Networking

extension OneCharacterViewController {
    
    func fetchSingleCharacterInfo() {
        NetworkManager.shared.fetch(Character.self, from: Link.singleCharacterUrl.rawValue) { [weak self] result in
            switch result {
            case .success(let character):
                self?.singleCharacter = character
                self?.nameLabel.text = "Name: \(character.name ?? "No data")"
                self?.genderLabel.text = "Gender: \(character.gender ?? "No data")"
                self?.cultureLabel.text = "Culture: \(character.culture ?? "No data")"
                self?.dateOfBirthLabel.text = "Date of birth: \(character.born ?? "No data")"
                self?.dateOfDeathLabel.text = "Date of death: \(character.died ?? "No data")"
                self?.titlesLabel.text = "Titles: \(character.titles?.joined(separator: ", ") ?? "No data")"
                self?.aliasesLabel.text = "Aliases: \(character.aliases?.joined(separator: ", ") ?? "No data")"
                self?.tvSeriesLabel.text = "TV series: \(character.tvSeries?.joined(separator: ", ") ?? "No data")"
                self?.playedByLabel.text = "Played by: \(character.playedBy?.joined(separator: ", ") ?? "No data")"
                self?.allegiancesLabel.text = "Allegiances: \(character.allegiances?.joined(separator: ", ") ?? "No data")"
                self?.fetchAllMainCaractersInfo()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchAllMainCaractersInfo() {
        NetworkManager.shared.fetch([Characters].self, from: Link.allCharactersUrl.rawValue) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.allCharacters = characters
                for character in characters {
                    if character.fullName == self?.singleCharacter?.name {
                        let url = character.imageUrl
                        NetworkManager.shared.fetchImage(from: url) { result in
                            switch result {
                            case .success(let imageData):
                                self?.characterImage.image = UIImage(data: imageData)
                                self?.activityIndicator.stopAnimating()
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

// MARK: UITextFieldDelegate

extension OneCharacterViewController: UITextFieldDelegate {
    
}
