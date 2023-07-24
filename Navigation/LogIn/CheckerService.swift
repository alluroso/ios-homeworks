//
//  CheckerService.swift
//  Navigation
//
//  Created by Алексей Калинин on 14.07.2023.
//

import Foundation
import FirebaseAuth
import RealmSwift

protocol CheckerServiceProtocol {
    func checkCredentials(login: String, password: String)
    func signUp(login: String, password: String)
}

class CheckerService: CheckerServiceProtocol {
    
    static let shared = CheckerService()
    
    var isSingUp: Bool = false
    
    func checkCredentials(login: String, password: String) {
        
        let newUser = RealmUser()
        newUser.login = login
        newUser.password = password
        newUser.isLogin = false
        
        let realm = try! Realm()
        
        let currentUser = realm.objects(RealmUser.self).filter("login == '\(login)'").first
        
        if currentUser == nil {
            try! realm.write {
                realm.add(newUser)
                NotificationCenter.default.post(name: Notification.Name("signUpSuccess"), object: nil)
            }
        } else {
            NotificationCenter.default.post(name: Notification.Name("userExists"), object: nil)
        }
    }
    
    func signUp(login: String, password: String) {
        
        let realm = try! Realm()
        
        let currentUser = realm.objects(RealmUser.self).filter("login == '\(login)'").first
        
        if currentUser == nil {
            NotificationCenter.default.post(name: Notification.Name("userNotExists"), object: nil)
        } else {
            if currentUser?.password == password {
                try! realm.write {
                    currentUser?.isLogin = true
                }
                
                UserDefaults.standard.set(true, forKey: "isLogin")
                
                NotificationCenter.default.post(name: Notification.Name("logInSuccess"), object: nil)
            } else {
                NotificationCenter.default.post(name: Notification.Name("passwordIsWrong"), object: nil)
            }
        }
    }
}
