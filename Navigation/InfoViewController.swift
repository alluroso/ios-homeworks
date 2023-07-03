//
//  InfoViewController.swift
//  Navigation
//
//  Created by Алексей Калинин on 20.01.2023.
//

import UIKit

class InfoViewController: UIViewController {

    private var firstURL = "https://jsonplaceholder.typicode.com/todos/1"
    private var planetURL = "https://swapi.dev/api/planets/1"
    private var peoplesID = "peoplesID"

    private var peoples: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private lazy var deleteButton: CustomButton = {
        let button = CustomButton(title: "Удалить", titleColor: .black, backgroundColor: .white, onTap: click)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "title: "
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.5
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let planetLabel: UILabel = {
        let label = UILabel()
        label.text = "orbital period: "
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.5
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray4
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "peoplesID")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubviews(deleteButton, firstLabel, planetLabel, tableView)
        setupConstrains()
        getTitle(with: firstURL)
        getOrbitalPeriod(with: planetURL)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupConstrains() {
        NSLayoutConstraint.activate([
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),

            firstLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstLabel.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 20),
            firstLabel.leadingAnchor.constraint(equalTo: deleteButton.leadingAnchor),
            firstLabel.trailingAnchor.constraint(equalTo: deleteButton.trailingAnchor),
            firstLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),

            planetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            planetLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 20),
            planetLabel.leadingAnchor.constraint(equalTo: deleteButton.leadingAnchor),
            planetLabel.trailingAnchor.constraint(equalTo: deleteButton.trailingAnchor),
            planetLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),

            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: planetLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: deleteButton.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: deleteButton.trailingAnchor),
            tableView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }

    private func getTitle(with stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data {
                do {
                    let serializationDict = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dict = serializationDict as? [String: Any], let title = dict["title"] as? String {
                        DispatchQueue.main.async {
                            self?.firstLabel.text = self!.firstLabel.text! + title
                        }
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }

    private func getOrbitalPeriod(with stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data {
                do {
                    let serializationDict = try JSONDecoder().decode(Planets.self, from: data)
                    DispatchQueue.main.async {
                        self?.planetLabel.text = self!.planetLabel.text! + serializationDict.orbitalPeriod
                    }
                    self?.loadPeople(from: serializationDict.residents)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }

    private func loadPeople(from array: [String]) {
        array.forEach { stringURL in
            guard let url = URL(string: stringURL) else { return }
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data {
                    do {
                        let serializationDict = try JSONDecoder().decode(People.self, from: data)
                        self?.peoples.append(serializationDict.name)
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
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

extension InfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        peoples.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: peoplesID, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = peoples[indexPath.row]
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
}
