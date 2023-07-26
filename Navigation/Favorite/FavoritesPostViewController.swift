//
//  FavoritesPostViewController.swift
//  Navigation
//
//  Created by Алексей Калинин on 26.07.2023.
//

import Foundation
import UIKit
import StorageService

class FavoritesPostViewController: UIViewController, UITableViewDelegate {
    
    let tabBar = UITabBarItem(title: "Избранное",
                              image: UIImage(systemName: "star"),
                              selectedImage: UIImage(systemName: "star.fill"))
    
    var favorites = [Post]() {
        didSet {
            tableView.reloadData() } }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return tableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = tabBar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Избранное"
        
        setupViews()
        constraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favorites = CoreDataManager.shared.showFavorites()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FavoritesPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.setupCell(post: favorites[indexPath.row])
        return cell
    }
}
