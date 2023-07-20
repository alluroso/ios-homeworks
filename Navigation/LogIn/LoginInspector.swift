//
//  LoginInspector.swift
//  Navigation
//
//  Created by Алексей Калинин on 29.03.2023.
//

import Foundation

class LoginInspector: LoginViewControllerDelegate {

    func check(login: String, password: String) -> Bool {
        Navigation.CheckerService.shared.checkCredentials(login: login, password: password)
        if Navigation.CheckerService.shared.isSingUp == true {
            return true
        } else {
            return false
        }
    }
}
