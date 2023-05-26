//
//  BruteForce.swift
//  Navigation
//
//  Created by Алексей Калинин on 26.05.2023.
//

import Foundation

class BruteForce {

    static let shared = BruteForce()

    let charactersArray = ["a", "b", "c", "d", "e", "f", "g",
                           "h", "i", "j", "k", "l", "m", "n",
                           "o", "p", "q", "r", "s", "t", "u",
                           "v", "w", "x", "y", "z","A", "B",
                           "C", "D", "E", "F", "G", "H", "I",
                           "J", "K", "L", "M", "N", "O", "P",
                           "Q", "R", "S", "T", "U", "V", "W",
                           "X", "Y", "Z", "1", "2", "3", "4",
                           "5", "6", "7", "8", "9", "0"]

    func generate(length: Int) -> [String] {
        if length == 1 {
            return charactersArray
        } else {
            let subStrings = generate(length: length - 1)

            var newCharactersArray = [String]()
            for i in charactersArray {
                for sub in subStrings {
                    newCharactersArray.append(i + sub)
                }
            }
            return newCharactersArray
        }
    }
}

class GeneratePassword {

    static let shared = GeneratePassword()

    var generatedPassword = ""

    func generatePass(count: Int) {
        generatedPassword = ""

        let charactersArray: [String] = ["a", "b", "c", "d", "e", "f", "g",
                                         "h", "i", "j", "k", "l", "m", "n",
                                         "o", "p", "q", "r", "s", "t", "u",
                                         "v", "w", "x", "y", "z","A", "B",
                                         "C", "D", "E", "F", "G", "H", "I",
                                         "J", "K", "L", "M", "N", "O", "P",
                                         "Q", "R", "S", "T", "U", "V", "W",
                                         "X", "Y", "Z", "1", "2", "3", "4",
                                         "5", "6", "7", "8", "9", "0"]

        for _ in 1...count {
            let newCharactersArray = charactersArray.randomElement()
            guard let str = newCharactersArray else { return }
            generatedPassword.append(str)
        }
    }
}
