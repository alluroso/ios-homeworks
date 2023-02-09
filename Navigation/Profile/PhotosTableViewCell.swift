//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Алексей Калинин on 06.02.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private let photosLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let arrowGallery: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.forward")
        image.tintColor = .black
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var photoFirst: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "1")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var photoSecond: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "2")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var photoThird: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "3")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var photoFourth: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "4")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 6
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        constraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubviews(photosLabel, arrowGallery, photoFirst, photoSecond, photoThird, photoFourth)
    }

    private func constraints() {
        NSLayoutConstraint.activate([
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photosLabel.trailingAnchor.constraint(lessThanOrEqualTo: arrowGallery.leadingAnchor,
                                                  constant: UIScreen.main.bounds.width - 100),

            arrowGallery.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowGallery.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowGallery.widthAnchor.constraint(equalTo: arrowGallery.heightAnchor),
            arrowGallery.heightAnchor.constraint(equalTo: photosLabel.heightAnchor),

            photoFirst.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            photoFirst.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoFirst.trailingAnchor.constraint(equalTo: photoSecond.leadingAnchor, constant: -8),
            photoFirst.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48) / 4),
            photoFirst.heightAnchor.constraint(equalTo: photoFirst.widthAnchor),
            photoFirst.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            photoSecond.topAnchor.constraint(equalTo: photoFirst.topAnchor),
            photoSecond.trailingAnchor.constraint(equalTo: photoThird.leadingAnchor, constant: -8),
            photoSecond.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48) / 4),
            photoSecond.heightAnchor.constraint(equalTo: photoSecond.widthAnchor),
            photoSecond.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            photoThird.topAnchor.constraint(equalTo: photoFirst.topAnchor),
            photoThird.trailingAnchor.constraint(equalTo: photoFourth.leadingAnchor, constant: -8),
            photoThird.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48) / 4),
            photoThird.heightAnchor.constraint(equalTo: photoThird.widthAnchor),
            photoThird.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            photoFourth.topAnchor.constraint(equalTo: photoFirst.topAnchor),
            photoFourth.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photoFourth.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48) / 4),
            photoFourth.heightAnchor.constraint(equalTo: photoFourth.widthAnchor),
            photoFourth.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
