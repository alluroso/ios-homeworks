//
//  FeedViewController.swift
//  Navigation
//
//  Created by Алексей Калинин on 20.01.2023.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {

    let tabBar = UITabBarItem(title: "Главная",
                              image: UIImage(systemName: "house"),
                              selectedImage: UIImage(systemName: "house.fill"))
    
    var post = Post(title: "Пост 1")

    private let buttonVSView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let guessWordHSView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var postButtonFirst: CustomButton = {
        let button = CustomButton(title: "Пост 1", titleColor: .black, backgroundColor: .systemMint, onTap: click)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
//        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var postButtonSecond: CustomButton = {
        let button = CustomButton(title: "Пост 2", titleColor: .black, backgroundColor: .systemPurple, onTap: click)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
//        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Check word", titleColor: .black, backgroundColor: .orange, onTap: buttonCheckWord)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
//        button.addTarget(self, action: #selector(buttonCheckWord), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var wordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a word"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var checkGuessLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = .systemGray6
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var passwordHint: UILabel = {
        let label = UILabel()
        label.text = "Correctly: smile"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = .systemIndigo
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(){
        super.init(nibName: nil, bundle: nil)
        title = tabBar.title
        tabBarItem = tabBar
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemIndigo
        view.addSubview(buttonVSView)

        buttonVSView.addArrangedSubview(postButtonFirst)
        buttonVSView.addArrangedSubview(postButtonSecond)
        buttonVSView.addArrangedSubview(guessWordHSView)
        buttonVSView.addArrangedSubview(passwordHint)

        guessWordHSView.addArrangedSubview(wordTextField)
        guessWordHSView.addArrangedSubview(checkGuessButton)
        guessWordHSView.addArrangedSubview(checkGuessLabel)

        constraints()
        hideKeyboard()
    }

    private func constraints() {
        NSLayoutConstraint.activate([
            buttonVSView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            buttonVSView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            buttonVSView.widthAnchor.constraint(equalToConstant: 350),
            buttonVSView.heightAnchor.constraint(equalToConstant: 245)
        ])
    }
    
    @objc func click(sender: UIButton!) {
        let postVC = PostViewController()
        postVC.title = post.title
        navigationController?.pushViewController(postVC, animated: true)
    }

    @objc func buttonCheckWord(sender: UIButton!) {

        let word = wordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if word != "" {
            let feedModel = FeedModel()
            checkGuessLabel.backgroundColor = feedModel.check(word) ? .green : .red

            let alert = UIAlertController(
                title: feedModel.check(word) ? "Right" : "Wrong",
                message: feedModel.check(word) ? "Cool" : "Try again.",
                preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            alert.view.tintColor = .black
            self.present(alert, animated: true, completion: nil)
        } else {
            checkGuessLabel.text = ""
            checkGuessLabel.backgroundColor  = .gray

            let alert = UIAlertController(
                title: "Enter a word",
                message: "Enter a word and try again.",
                preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            alert.view.tintColor = .black
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension UIView {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        self.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}
