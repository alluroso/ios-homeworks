//
//  RealmModel.swift
//  Navigation
//
//  Created by Алексей Калинин on 24.07.2023.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    
    @Persisted var login: String
    @Persisted var password: String
    @Persisted var isLogin: Bool
}
