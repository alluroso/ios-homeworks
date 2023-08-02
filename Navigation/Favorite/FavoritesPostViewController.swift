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
    
    var favorites = [Post]()
    
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
        setupBarButton()
        constraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favorites = CoreDataManager.shared.showFavorites()
        tableView.reloadData()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupBarButton() {
        let filterButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(changeFilter))
        let clearButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearFilter))
        navigationItem.setLeftBarButtonItems([filterButton], animated: true)
        navigationItem.setRightBarButtonItems([clearButton], animated: true)
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func changeFilter() {
        let alert = UIAlertController(title: "Поиск по автору", message: nil, preferredStyle: .alert)
        alert.view.tintColor = .black
        alert.addTextField { textField in
            textField.placeholder = "Введите имя"
        }
        let action = UIAlertAction(title: "Применить", style: .default) { [self] action in
            guard let text = alert.textFields?[0].text, text != "" else { return }
            self.favorites = CoreDataManager.shared.showFavorites(author: text)
            tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Отмена", style: .default)
        alert.addAction(cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @objc func clearFilter() {
        self.favorites = CoreDataManager.shared.showFavorites()
        tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (contextualAction, view, boolValue) in

            guard let self = self else { return }

            CoreDataManager.shared.deletePost(self.favorites[indexPath.row])
            self.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
}
