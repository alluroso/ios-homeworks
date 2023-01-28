//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Алексей Калинин on 25.01.2023.
//

import UIKit

final class ProfileHeaderView: UIView {

    private var statusText = ""

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(profileImage)
        self.addSubview(nameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(statusButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "imageProfile")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 100 / 2
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
        return image
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Cillian Murphy"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Actor, musician"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter new status"
        textField.clearButtonMode = .whileEditing
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.clipsToBounds = true
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)

        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        return textField
    }()

    lazy var statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 14
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    @objc func buttonPressed() {
        statusLabel.text = statusText
    }

    @objc func statusTextChanged(_ textField: UITextField) {
        if let setStatus = textField.text {
            statusText = setStatus
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        profileImage.frame = CGRect(x: 16, y: 16, width: 100, height: 100)
        nameLabel.frame = CGRect(x: profileImage.frame.maxX + 20, y: 27, width: 150, height: 18)
        statusButton.frame = CGRect(x: 16, y: profileImage.frame.maxY + 40, width: self.frame.width - 32, height: 50)
        statusLabel.frame = CGRect(x: profileImage.frame.maxX + 20, y: statusTextField.frame.minY - 10 - 14, width: 150, height: 14)
        statusTextField.frame = CGRect(x: profileImage.frame.maxX + 20, y: statusButton.frame.minY - 16 - 40, width: self.frame.width - profileImage.frame.maxX - 20 - 16, height: 40)
    }
}
