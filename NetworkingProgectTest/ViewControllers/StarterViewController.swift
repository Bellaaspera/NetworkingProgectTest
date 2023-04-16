//
//  StarterViewController.swift
//  NetworkingProgectTest
//
//  Created by Светлана Сенаторова on 16.04.2023.
//

import UIKit

class StarterViewController: UIViewController {

    @IBOutlet var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImage.image = UIImage(named: "gameOfThrones5")
    }
    
    @IBAction func showMeButtonPressed() {
        performSegue(withIdentifier: "showCharacters", sender: nil)
    }
    
//    MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBarVC = segue.destination as? UITabBarController else { return }
        guard let oneCharacterVC = tabBarVC.viewControllers?.first as? OneCharacterViewController else { return }
        guard let CharactersVC = tabBarVC.viewControllers?.last as? CharactersViewController else { return }
        oneCharacterVC.fetchSingleCharacterInfo()
        CharactersVC.fetchAllMainCaractersInfo()
    }

}
