//
//  CustomButton.swift
//  Navigation
//
//  Created by Алексей Калинин on 06.04.2023.
//

import UIKit

final class CustomButton: UIButton {

    var onTap: (() -> Void)?

    init(title: String, titleColor: UIColor, backgroundColor: UIColor) {
        super.init(frame: .zero)

        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.addTarget(self, action: #selector(buttonTapped(_ :)), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        onTap?()
    }

}
