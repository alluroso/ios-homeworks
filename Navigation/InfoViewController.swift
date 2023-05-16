//
//  InfoViewController.swift
//  Navigation
//
//  Created by Алексей Калинин on 20.01.2023.
//

import UIKit

class InfoViewController: UIViewController {

    func deleteButton() {
        let button = CustomButton(title: "Удалить", titleColor: .black, backgroundColor: .white, onTap: click)
        button.frame = CGRect(x: view.bounds.width / 2 - 90, y: view.bounds.height / 2 - 20, width: 180, height: 40)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
//        button.addTarget(self, action: #selector(click), for: .touchUpInside)
        view.addSubview(button)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        deleteButton()
    }

    @objc func click(sender: UIButton!) {
        let alertVC = UIAlertController(title: "Удалить?", message: "Информация будет удалена", preferredStyle: .alert)

        let actionYes = UIAlertAction(title: "Да", style: .default) { _ in print ("Да")}
        alertVC.addAction(actionYes)
        let actionNo = UIAlertAction(title: "Нет", style: .default) { _ in print ("Нет")}
        alertVC.addAction(actionNo)
        self.present(alertVC, animated: true, completion: nil)
    }
}
