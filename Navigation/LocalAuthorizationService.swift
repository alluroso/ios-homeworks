//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Алексей Калинин on 21.09.2023.
//

import UIKit
import LocalAuthentication

class LocalAuthorizationService {
    
    let context = LAContext()
    var canUseBiometrics: Bool?
    var policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
    var biometryType: LABiometryType {
        return context.biometryType
    }
    var error: NSError?
    
    init() {
        canUseBiometrics = context.canEvaluatePolicy(policy, error: &error)
    }
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void) {
        
        if let error = error {
            authorizationFinished(false, error)
            return
        }
        
        context.localizedCancelTitle = NSLocalizedString("LocalAuthorizationServiceLocalizedCancelTitle", comment: "")
        context.evaluatePolicy(policy,
                               localizedReason: NSLocalizedString("LocalAuthorizationServiceLocalizedReason", comment: ""))
        { success, error in
            DispatchQueue.main.async {
                if success {
                    authorizationFinished(success, nil)
                }
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
