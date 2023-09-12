//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Алексей Калинин on 25.01.2023.
//

import UIKit
import SnapKit

final class ProfileHeaderView: UIView {

    private(set) lazy var profileImage: UIImageView = {
        let image = UIImageView()
        //        image.image = UIImage(named: "imageProfile")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 100 / 2
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        let tap = UITapGestureRecognizer(target: self, action: #selector(openProfileImage))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        return image
    }()

    private lazy var profileImageEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)

        let profileImageEffectView = UIVisualEffectView(effect: blurEffect)
        profileImageEffectView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        profileImageEffectView.layer.opacity = 0
        profileImageEffectView.isUserInteractionEnabled = false
        return profileImageEffectView
    }()

    private lazy var closeProfileImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))?.withTintColor(Palette.blackWhite, renderingMode: .alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        button.layer.opacity = 0
        button.addTarget(self, action: #selector(closeProfileImage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        //        label.text = "Cillian Murphy"
        label.textColor = Palette.blackWhite
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private(set) lazy var statusLabel: UILabel = {
        let label = UILabel()
        //        label.text = "Actor, musician"
        label.textColor = Palette.grayWhite
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter new status".localized
        textField.clearButtonMode = .whileEditing
        textField.textColor = Palette.blackWhite
        textField.backgroundColor = Palette.whiteGray2
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.clipsToBounds = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false

        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = spacerView
        return textField
    }()

    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status".localized, for: .normal)
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

    private var statusText = ""
    private var profileImageCenter = CGPoint(x: 0, y: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        constraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func openProfileImage() {
        UIImageView.animate(withDuration: 0.5,
                            animations: { [self] in
            profileImageCenter = profileImage.center
            profileImage.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY - profileImageCenter.y)
            profileImage.transform = CGAffineTransform(scaleX: bounds.width / profileImage.frame.width, y: bounds.width / profileImage.frame.width)
            profileImage.layer.cornerRadius = 0
            profileImage.layer.borderWidth = 0
            profileImageEffectView.layer.opacity = 1

            profileImage.isUserInteractionEnabled = false
            statusTextField.isUserInteractionEnabled = false
            statusButton.isUserInteractionEnabled = false
            ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = false
            ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 1))?.isUserInteractionEnabled = false
            ProfileViewController.tableView.isScrollEnabled = false
        },
                            completion: { _ in
            UIImageView.animate(withDuration: 0.3) { [self] in
                closeProfileImageButton.layer.opacity = 1
            }
        })
    }

    @objc func closeProfileImage() {
        UIImageView.animate(withDuration: 0.3,
                            animations: { [self] in
            closeProfileImageButton.layer.opacity = 0
        },
                            completion: { _ in
            UIImageView.animate(withDuration: 0.5) { [self] in
                profileImage.center = profileImageCenter
                profileImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                profileImage.layer.cornerRadius = profileImage.frame.height / 2
                profileImage.layer.borderWidth = 3
                profileImageEffectView.layer.opacity = 0

                profileImage.isUserInteractionEnabled = true
                statusTextField.isUserInteractionEnabled = true
                statusButton.isUserInteractionEnabled = true
                ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = true
                ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 1))?.isUserInteractionEnabled = true
                ProfileViewController.tableView.isScrollEnabled = true
            }
        })
    }

    @objc func buttonPressed() {
        statusLabel.text = statusText
        self.endEditing(true)
    }

    @objc func statusTextChanged(_ textField: UITextField) {
        if let setStatus = textField.text {
            statusText = setStatus
        }
    }

    private func setupViews() {
        [nameLabel, statusLabel, statusButton, statusTextField, profileImageEffectView, profileImage, closeProfileImageButton].forEach { addSubview($0) }
    }

    private func constraints() {
        profileImage.snp.makeConstraints { maker in
            maker.top.equalTo(16)
            maker.leading.equalTo(16)
            maker.height.width.equalTo(100)
        }

        nameLabel.snp.makeConstraints { maker in
            maker.top.equalTo(27)
            maker.leading.equalTo(132)
            maker.trailing.equalTo(-16)
            maker.height.equalTo(18)
        }

        statusLabel.snp.makeConstraints { maker in
            maker.top.equalTo(nameLabel.snp.bottom).offset(35)
            maker.leading.equalTo(nameLabel.snp.leading)
            maker.trailing.equalTo(-16)
            maker.height.equalTo(14)
        }

        statusTextField.snp.makeConstraints { maker in
            maker.top.equalTo(statusLabel.snp.bottom).offset(10)
            maker.leading.equalTo(nameLabel.snp.leading)
            maker.trailing.equalTo(-16)
            maker.height.equalTo(40)
        }

        statusButton.snp.makeConstraints { maker in
            maker.top.equalTo(statusTextField.snp.bottom).offset(10)
            maker.leading.equalTo(16)
            maker.trailing.equalTo(-16)
            maker.height.equalTo(50)
            maker.bottom.equalTo(-16)
        }

        closeProfileImageButton.snp.makeConstraints { maker in
            maker.top.equalTo(16)
            maker.trailing.equalTo(-16)
        }
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
