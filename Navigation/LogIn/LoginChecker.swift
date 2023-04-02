//
//  Checker.swift
//  Navigation
//
//  Created by Алексей Калинин on 29.03.2023.
//

import Foundation

class Checker {

    static let shared: Checker = {
        return Checker()
    }()

#if DEBUG
    private let login: String = {
        return "test"
    }()

    private let password: String = {
        return "test"
    }()

#else
    private let login: String = {
        return "alluroso"
    }()

    private let password: String = {
        return "1234"
    }()
#endif

    private init() {}

    func check(login: String, password: String) -> Bool {
        return self.login == login && self.password == password
    }
}
