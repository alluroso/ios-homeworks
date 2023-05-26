//
//  Photo.swift
//  Navigation
//
//  Created by Алексей Калинин on 06.02.2023.
//

import UIKit

struct Photo {
    let imageName: String
    let photo: UIImage

    static func arrayPhotos() -> [Photo] {
        var names = [Photo]()
        for index in 1...20 {
            names.append(Photo(imageName: "\(index)", photo: UIImage(named: "\(index)")!))
        }
        return names
    }

    static func arrayImages() -> [UIImage] {
        var images = [UIImage]()
        for index in 1...20 {
            images.append(UIImage(named: "\(index)")!)
        }
        return images
    }
}
