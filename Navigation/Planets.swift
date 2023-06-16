//
//  Planets.swift
//  Navigation
//
//  Created by Алексей Калинин on 16.06.2023.
//

import Foundation

struct Planets: Decodable {
    let name: String
    let orbitalPeriod: String
    let residents: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case orbitalPeriod = "orbital_period"
        case residents
    }
}
