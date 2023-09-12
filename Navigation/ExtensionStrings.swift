//
//  ExtensionStrings.swift
//  Navigation
//
//  Created by Алексей Калинин on 09.09.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
