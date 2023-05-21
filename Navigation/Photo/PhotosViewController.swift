//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Алексей Калинин on 06.02.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {

    private var sourceArray = Photo.arrayImages()
    private var filterArray = [CGImage?]()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Gallery"
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        benchmarkQOS()
        constraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }

    private func benchmarkQOS() {
        let startTime = Date()
        print("Начало обработки")

        ImageProcessor().processImagesOnThread(sourceImages: Photo.arrayImages(), filter: .bloom(intensity: 5.0), qos: .background) {
            self.filterArray = $0
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }

            let endTime = Date()
            let timeElapsed = endTime.timeIntervalSince(startTime)
            print("Конец обработки. Время: \(timeElapsed) секунды")
        }
        /*
         Время обработки изображений с различными фильтрами QOS
         background - 5.2 секунд
         default - 1.2 секунды
         userInitiated - 1.3 секунды
         userInteractive - 1.3 секунды
         utility - 1.4 секунды
         */
    }

    private func constraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filterArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        var image = UIImage()
        if let cgImage =  filterArray[indexPath.row] {
            image = UIImage(cgImage: cgImage)
        } else {
            image = UIImage(systemName: "photo.fill")!
        }
        cell.setupCell(photo: image)
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 32) / 3
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
