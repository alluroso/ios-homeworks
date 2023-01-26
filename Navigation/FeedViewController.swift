//
//  FeedViewController.swift
//  Navigation
//
//  Created by Алексей Калинин on 20.01.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Пост 1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Главная"
        self.view.backgroundColor = .systemGray6

        view.addSubview(buttonVSView)
        buttonVSView.addArrangedSubview(postButtonFirst)
        buttonVSView.addArrangedSubview(postButtonSecond)
        constraints()
    }

    private let buttonVSView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var postButtonFirst: UIButton = {
        let button = UIButton()
        button.setTitle("Пост 1", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var postButtonSecond: UIButton = {
        let button = UIButton()
        button.setTitle("Пост 2", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private func constraints() {
        NSLayoutConstraint.activate([
            buttonVSView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            buttonVSView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            buttonVSView.widthAnchor.constraint(equalToConstant: 180),
            buttonVSView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    @objc func click() {
        let postVC = PostViewController()
        postVC.title = post.title
        navigationController?.pushViewController(postVC, animated: true)
    }
}
