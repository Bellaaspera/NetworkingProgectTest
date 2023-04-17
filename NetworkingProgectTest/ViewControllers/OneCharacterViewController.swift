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
    
    private var singleCharacter: Character?
    private var allCharacters: [Characters]?
    private var characterID = 583
    private var allegiances: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchSingleCharacterInfo()
        addToolBar()
    }

    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func showAllegiancesButtonPressed() {
        performSegue(withIdentifier: "showAllegiances", sender: nil)
    }
    
    @objc private func donePressed() {
        view.endEditing(true)
        fetchSingleCharacterInfo()
    }
    
    private func addToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        idTextField.inputAccessoryView = toolBar
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(donePressed)
        )
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        toolBar.items = [flexBarButton, doneButton]
    }
    
}

// MARK: - Networking

extension OneCharacterViewController {
    
   private func fetchSingleCharacterInfo() {
        NetworkManager.shared.fetch(Character.self, from: Link.singleCharacterUrl.rawValue + String(characterID)) { [weak self] result in
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
                self?.allegiances = character.allegiances ?? []
                self?.fetchAllMainCaractersInfo()
            case .failure(let error):
                print(error)
            }
        }
    }
    
   private func fetchAllMainCaractersInfo() {
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
                    } else if character.fullName != self?.singleCharacter?.name {
                        self?.characterImage.image = UIImage(systemName: "person.fill")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension OneCharacterViewController: UITextFieldDelegate {
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = idTextField.text, !text.isEmpty else {
            showAlert(with: "Id required!", message: "Please, enter characters ID")
            return
        }
        guard let numberId = Int(text), numberId < 600 else {
            showAlert(with: "Wrong ID!", message: "Please, enter numeral Id")
            return
        }
        characterID = numberId
    }
    
}

// MARK: - UIAlertController

extension OneCharacterViewController {
    private func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.idTextField.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: Navigation

extension OneCharacterViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let allegiancesVC = navigationVC.topViewController as? AllegiancesTableViewController else { return }
        allegiancesVC.allegiancesLinks = allegiances
    }
    
}
