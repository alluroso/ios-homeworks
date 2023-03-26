//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Алексей Калинин on 26.03.2023.
//

import UIKit

final class CurrentUserService: UserService {

    let user = User(login: "alluroso", fullName: "Cillian Murphy", avatar: UIImage(named: "imageProfile"), status: "Actor, musician")

    func getUser(login: String) -> User? {

        if login == user.login {
            return user
        } else {
            return nil
        }
    }
}
