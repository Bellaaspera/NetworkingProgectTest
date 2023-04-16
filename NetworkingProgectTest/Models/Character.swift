//
//  Character.swift
//  NetworkingProgectTest
//
//  Created by Светлана Сенаторова on 14.04.2023.
//

import Foundation

struct Character: Codable {
    let name: String?
    let gender: String?
    let culture: String?
    let born: String?
    let died: String?
    let titles: [String]?
    let aliases: [String]?
    let tvSeries: [String]?
    let playedBy: [String]?
    let allegiances: [String]?
    let povBooks: [String]?
}

struct Characters: Codable {
    let firstName: String?
    let lastName: String?
    let fullName: String?
    let title: String?
    let family: String?
    let image: String?
    let imageUrl: String?
}
