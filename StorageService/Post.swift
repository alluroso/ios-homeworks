//
//  Post.swift
//  Navigation
//
//  Created by Алексей Калинин on 20.01.2023.
//

import Foundation

public struct Post {
    public let title: String
    public let author: String
    public let description: String
    public let image: String
    public var likes: Int
    public var views: Int
    
    public init (title: String = "",
                 author: String = "",
                 image: String = "",
                 description: String = "",
                 likes: Int = 0,
                 views: Int = 0) {
        self.title = title
        self.author = author
        self.image = image
        self.description = description
        self.likes = likes
        self.views = views
    }

    public static func arrayPosts() -> [Post] {
        var posts = [Post]()
        posts.append(Post(
            author: "Marilynn",
            image: "rome",
            description: """
        Рим — столица Италии, один из старейших городов мира и древняя столица Римской империи. Туристы с трудом могут устоять перед оглушительным шумом, суетой и оживлением нового Рима, перемежающимися с тихими и безмятежными островками старого города.
        """,
            likes: 381,
            views: 513)
        )

        posts.append(Post(
            author: "Kevin",
            image: "newyork",
            description: """
        Нью-Йорк — крупнейший город США, входящий в одну из крупнейших агломераций мира.
        """,
            likes: 242,
            views: 449)
        )

        posts.append(Post(
            author: "Jehanne",
            image: "paris",
            description: """
        Париж — столица Франции, самый красивый и элегантный город мира, символ любви и романтики, моды и изысканности. Нет такого человека, который не мечтал бы посетить Париж, увидеть ставшие хрестоматийными достопримечательности, окунуться в атмосферу раскованности, отдать должное французской кухне, побродить по красивым бульварам.
        """,
            likes: 206,
            views: 578)
        )

        posts.append(Post(
            author: "Dwayne",
            image: "venice",
            description: """
        Венеция — самый романтичный уголок Европы, расположенный на северном побережье Адриатического моря в Италии.
        """,
            likes: 99,
            views: 231)
        )
        return posts
    }
}
