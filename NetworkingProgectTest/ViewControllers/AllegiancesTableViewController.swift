//
//  AllegiancesTableViewController.swift
//  NetworkingProgectTest
//
//  Created by Светлана Сенаторова on 17.04.2023.
//

import UIKit

class AllegiancesTableViewController: UITableViewController {

    var allegiancesLinks: [String] = []
    var episodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 300
        print("\(allegiancesLinks) is loaded")
        fetchEpisode()
        print(episodes)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell") as? EpisodeTableViewCell else { return UITableViewCell() }
        cell.configure(with: episodes[indexPath.row])
        return cell
    }
}

// MARK: - Networking

extension AllegiancesTableViewController {
    
    func fetchEpisode() {
        for link in allegiancesLinks {
            NetworkManager.shared.fetch(Episode.self, from: link) { [weak self] result in
                switch result {
                case .success(let episode):
                    self?.episodes.append(episode)
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
