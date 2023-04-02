//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Алексей Калинин on 29.03.2023.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}
