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

        setupViews()
        constraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "imageProfile")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 100 / 2
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Cillian Murphy"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Actor, musician"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusTextField: UITextField = {
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
        textField.translatesAutoresizingMaskIntoConstraints = false

        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        return textField
    }()

    private lazy var statusButton: UIButton = {
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
        button.translatesAutoresizingMaskIntoConstraints = false
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

    private func setupViews() {
        self.addSubview(profileImage)
        self.addSubview(nameLabel)
        self.addSubview(statusLabel)
        self.addSubview(statusTextField)
        self.addSubview(statusButton)
    }

    private func constraints() {
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 18)
        ])

        NSLayoutConstraint.activate([
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -10),
            statusLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusLabel.heightAnchor.constraint(equalToConstant: 14)
        ])

        NSLayoutConstraint.activate([
            statusTextField.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -10),
            statusTextField.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            statusButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 40),
            statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
