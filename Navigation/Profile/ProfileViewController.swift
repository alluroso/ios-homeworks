//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Алексей Калинин on 20.01.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView()

    let posts = Post.arrayPosts()

    static let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        title = "Профиль"

        setupViews()
        constraints()
    }

    private func setupViews() {
        view.addSubview(ProfileViewController.tableView)
        ProfileViewController.tableView.dataSource = self
        ProfileViewController.tableView.delegate = self
    }

    private func constraints() {
        NSLayoutConstraint.activate([
            ProfileViewController.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ProfileViewController.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ProfileViewController.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ProfileViewController.tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        }
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.setupSell(post: posts[indexPath.row])
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ProfileHeaderView()
        if section == 0  { return header }
        else { return nil }
    }

//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return section == 0 ? 220 : 0
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let photosVC = PhotosViewController()
            self.navigationController?.pushViewController(photosVC, animated: true)
        }
    }
}
