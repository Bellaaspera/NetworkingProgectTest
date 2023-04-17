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

}
