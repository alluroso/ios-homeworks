//
//  FeedViewController.swift
//  Navigation
//
//  Created by Алексей Калинин on 20.01.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post1 = Post(title: "Пост 1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Главная"
        self.view.backgroundColor = .systemGray6
        
        let postButton = UIButton()
        postButton.frame.size = CGSize(width: 180.0, height: 40.0)
        postButton.setTitle(post1.title, for: .normal)
        postButton.setTitleColor(.black, for: .normal)
        postButton.backgroundColor = .orange
        postButton.addTarget(self, action: #selector(click), for: .touchUpInside)
        postButton.center = self.view.center
        view.addSubview(postButton)
    }
    
    @objc func click() {
        let postVC = PostViewController()
        postVC.title = post1.title
        navigationController?.pushViewController(postVC, animated: true)
    }
}
