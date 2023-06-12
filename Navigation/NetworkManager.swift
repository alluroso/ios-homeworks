//
//  NetworkManager.swift
//  Navigation
//
//  Created by Алексей Калинин on 12.06.2023.
//

import Foundation

struct NetworkManager {
    static func request(for configaration: AppConfiguration) {
        if let url = URL(string: configaration.rawValue) {

            let task = URLSession.shared.dataTask(with: url) { data, response, error in

                if let data = data {
                    let stringUTF8 = String(decoding: data, as: UTF8.self)
                    print("data - \(stringUTF8)")
                }

                if let response = response as? HTTPURLResponse {
                    print("allHeaderFields - \(response.allHeaderFields)")
                    print("statusCode - \(response.statusCode)")
                }

                if error != nil {
                    print("error - \(error.debugDescription)")
                }
            }
            task.resume()
        }
    }
}

enum AppConfiguration: String, CaseIterable {
    case url1 = "https://swapi.dev/api/people/8"
    case url2 = "https://swapi.dev/api/starships/3"
    case url3 = "https://swapi.dev/api/planets/5"

    static func random() -> AppConfiguration {
        return allCases.randomElement()!
    }
}
