//
//  UserServiceProtocol.swift
//  Navigation
//
//  Created by Алексей Калинин on 26.03.2023.
//

import Foundation

protocol UserService {

    func getUser(login: String) -> User?
}
