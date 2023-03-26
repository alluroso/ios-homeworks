//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Алексей Калинин on 31.01.2023.
//

import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {

    private let contentCellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let postAuthorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let postImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let postLikesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let postViewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        constraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(post: Post) {
        postAuthorLabel.text = post.author
        postDescriptionLabel.text = post.description
        postLikesLabel.text = "Likes: \(post.likes)"
        postViewsLabel.text = "Views: \(post.views)"
        postImage.backgroundColor = .black
        if let image = UIImage(named: post.image) {
            let filter = ColorFilter.allCases[Int.random(in: 0..<ColorFilter.allCases.count)]
            ImageProcessor().processImage(sourceImage: image,
                                          filter: filter,
                                          completion: { postImage.image = $0 }
            )
        }
    }

    private func setupViews() {
        contentView.addSubviews(postAuthorLabel, postImage, postDescriptionLabel, postLikesLabel, postViewsLabel)
    }

    private func constraints() {
        NSLayoutConstraint.activate([
            postAuthorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            postAuthorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postAuthorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            postImage.topAnchor.constraint(equalTo: postAuthorLabel.bottomAnchor, constant: 16),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: self.frame.width),

            postDescriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            postLikesLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: 16),
            postLikesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postLikesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),

            postViewsLabel.topAnchor.constraint(equalTo: postLikesLabel.topAnchor),
            postViewsLabel.leadingAnchor.constraint(equalTo: postLikesLabel.trailingAnchor),
            postViewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postViewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            postViewsLabel.widthAnchor.constraint(equalTo: postLikesLabel.widthAnchor)
        ])
    }
}
