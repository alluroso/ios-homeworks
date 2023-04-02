//
//  LoginInspector.swift
//  Navigation
//
//  Created by Алексей Калинин on 29.03.2023.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        let checker = Checker.shared
        return checker.check(login: login, password: password)
    }
}
