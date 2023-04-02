//
//  LoginFactoryProtocol.swift
//  Navigation
//
//  Created by Алексей Калинин on 29.03.2023.
//

import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
