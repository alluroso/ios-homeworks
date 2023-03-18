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

    private lazy var postButtonFirst: UIButton = {
        let button = UIButton()
        button.setTitle("Пост 1", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var postButtonSecond: UIButton = {
        let button = UIButton()
        button.setTitle("Пост 2", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        constraints()
    }

    private func constraints() {
        NSLayoutConstraint.activate([
            buttonVSView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            buttonVSView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            buttonVSView.widthAnchor.constraint(equalToConstant: 320),
            buttonVSView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    @objc func click() {
        let postVC = PostViewController()
        postVC.title = post.title
        navigationController?.pushViewController(postVC, animated: true)
    }
}
