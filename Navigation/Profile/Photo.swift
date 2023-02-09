//
//  Photo.swift
//  Navigation
//
//  Created by Алексей Калинин on 06.02.2023.
//

import UIKit

struct Photo {
    let imageName: String

    static func arrayPhotos() -> [Photo] {
        var photos = [Photo]()
        for index in 1...20 {
            photos.append(Photo(imageName: "\(index)"))
        }
        return photos
    }
}
