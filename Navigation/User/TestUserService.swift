//
//  TestUserService.swift
//  Navigation
//
//  Created by Алексей Калинин on 26.03.2023.
//

import UIKit

final class TestUserService: UserService {

    let user = User(login: "test", fullName: "Test User", avatar: UIImage(named: "testImageProfile"), status: "Test status")

    func getUser(login: String) -> User? {

        if login == user.login {
            return user
        } else {
            return nil
        }
    }
}
