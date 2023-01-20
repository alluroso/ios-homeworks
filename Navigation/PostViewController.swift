//
//  PostViewController.swift
//  Navigation
//
//  Created by Алексей Калинин on 20.01.2023.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .orange
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .done, target: self, action: #selector(click))
    }

    @objc func click() {
        let infoVC = InfoViewController()
        infoVC.view.backgroundColor = .systemGray4
        infoVC.modalPresentationStyle = .automatic
        self.present(infoVC, animated: true, completion: nil)
    }
}
