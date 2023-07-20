//
//  CheckerService.swift
//  Navigation
//
//  Created by Алексей Калинин on 14.07.2023.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol {
    func checkCredentials(login: String, password: String)
    func signUp(login: String, password: String)
}

class CheckerService: CheckerServiceProtocol {
    
    static let shared = CheckerService()
    
    var isSingUp: Bool = false
    
    func checkCredentials(login: String, password: String) {
        
        Auth.auth().createUser(withEmail: login, password: password) { result, error in
            
            if let error = error {
                LogInViewController.signUpError = error.localizedDescription
                NotificationCenter.default.post(name: Notification.Name("signUpError"), object: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name("signUpSuccess"), object: nil)
            }
        }
    }
    
    func signUp(login: String, password: String) {
        
        Auth.auth().signIn(withEmail: login, password: password) { result, error in
            
            if let error = error {
                LogInViewController.logInError = error.localizedDescription
                NotificationCenter.default.post(name: Notification.Name("logInError"), object: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name("logInSuccess"), object: nil)
            }
        }
    }
}
