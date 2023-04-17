//
//  CharactersViewController.swift
//  NetworkingProgectTest
//
//  Created by Светлана Сенаторова on 14.04.2023.
//

import UIKit

class CharactersViewController: UIViewController {
    
    @IBOutlet var characterTableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var allCharacters: [Characters] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchAllMainCaractersInfo()
        characterTableView.rowHeight = 120
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

 // MARK: - Networking

extension CharactersViewController {
    
   private func fetchAllMainCaractersInfo() {
        NetworkManager.shared.fetch([Characters].self, from: Link.allCharactersUrl.rawValue) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.allCharacters = characters
                self?.characterTableView.reloadData()
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? MainCharactersTableViewCell else { return UITableViewCell() }
        cell.configure(with: allCharacters[indexPath.row])
        return cell
    }
    
    
}
