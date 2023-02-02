//
//  ExtensionUIView.swift
//  Navigation
//
//  Created by Алексей Калинин on 30.01.2023.
//

import UIKit

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for i in subviews {
            self.addSubview(i)
        }
    }
}
