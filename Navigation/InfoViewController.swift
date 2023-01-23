//
//  InfoViewController.swift
//  Navigation
//
//  Created by Алексей Калинин on 20.01.2023.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let deleteButton = UIButton()
        deleteButton.frame.size = CGSize(width: 180.0, height: 40.0)
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.backgroundColor = .white
        deleteButton.addTarget(self, action: #selector(click), for: .touchUpInside)
        deleteButton.center = self.view.center
        view.addSubview(deleteButton)
    }

    @objc func click() {
        let alertVC = UIAlertController(title: "Удалить?", message: "Информация будет удалена", preferredStyle: .alert)

        let actionYes = UIAlertAction(title: "Да", style: .default) { _ in print ("Да")}
        alertVC.addAction(actionYes)
        let actionNo = UIAlertAction(title: "Нет", style: .default) { _ in print ("Нет")}
        alertVC.addAction(actionNo)
        self.present(alertVC, animated: true, completion: nil)
    }
}
