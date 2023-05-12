//
//  CustomButton.swift
//  Navigation
//
//  Created by Алексей Калинин on 06.04.2023.
//

import UIKit

final class CustomButton: UIButton {

    var onTap: ((_: UIButton?) -> Void)!

    init(title: String, titleColor: UIColor, backgroundColor: UIColor, onTap: @escaping (_: UIButton?) -> Void) {
        super.init(frame: .zero)

        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.onTap = onTap
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonTapped() {
        if (onTap != nil) {
            self.onTap(self)
        }
    }
}
