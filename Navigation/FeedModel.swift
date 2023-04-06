//
//  FeedModel.swift
//  Navigation
//
//  Created by Алексей Калинин on 06.04.2023.
//

import Foundation

class FeedModel {

    let secretWord: String = "smile"

    func check(_ word: String) -> Bool {
        return word == secretWord
    }
}

