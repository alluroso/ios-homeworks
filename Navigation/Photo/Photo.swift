//
//  Photo.swift
//  Navigation
//
//  Created by Алексей Калинин on 06.02.2023.
//

import UIKit

//struct Photo {
//    let imageName: String
//
//    static func arrayPhotos() -> [Photo] {
//        var photos = [Photo]()
//        for index in 1...20 {
//            photos.append(Photo(imageName: "\(index)"))
//        }
//        return photos
//    }
//}

struct Photo {
    static let photo1 = UIImage(named: "1")!
    static let photo2 = UIImage(named: "2")!
    static let photo3 = UIImage(named: "3")!
    static let photo4 = UIImage(named: "4")!
    static let photo5 = UIImage(named: "5")!
    static let photo6 = UIImage(named: "6")!
    static let photo7 = UIImage(named: "7")!
    static let photo8 = UIImage(named: "8")!
    static let photo9 = UIImage(named: "9")!
    static let photo10 = UIImage(named: "10")!
    static let photo11 = UIImage(named: "11")!
    static let photo12 = UIImage(named: "12")!
    static let photo13 = UIImage(named: "13")!
    static let photo14 = UIImage(named: "14")!
    static let photo15 = UIImage(named: "15")!
    static let photo16 = UIImage(named: "16")!
    static let photo17 = UIImage(named: "17")!
    static let photo18 = UIImage(named: "18")!
    static let photo19 = UIImage(named: "19")!
    static let photo20 = UIImage(named: "20")!
}

extension Photo {
    static func arrayPhotos() -> [UIImage] {
        return [Photo.photo1, Photo.photo2, Photo.photo3, Photo.photo4, Photo.photo5, Photo.photo6, Photo.photo7, Photo.photo8, Photo.photo9, Photo.photo10, Photo.photo11, Photo.photo12, Photo.photo13, Photo.photo14, Photo.photo15, Photo.photo16, Photo.photo17, Photo.photo18, Photo.photo19, Photo.photo20]
    }
}
