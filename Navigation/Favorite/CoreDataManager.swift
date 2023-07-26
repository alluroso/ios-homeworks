//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Алексей Калинин on 26.07.2023.
//

import CoreData
import Foundation
import StorageService

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
        
    init() {}
    
    func save(_ post: Post) {
        Model.create(with: post, using: persistentContainer.viewContext)
    }
    
    func showFavorites() -> [Post] {
        let request = NSFetchRequest<Model>(entityName: "Model")
        guard let fetchRequestResult = try? persistentContainer.viewContext.fetch(request) else { return [] }
        return fetchRequestResult.map { $0.toPost() }
    }
}

extension Model {
    static func create(with post: Post, using context: NSManagedObjectContext) {
        let model = Model(context: context)
        model.title = post.title
        model.author = post.author
        model.descript = post.description
        model.image = post.image
        model.likes = Int64(post.likes)
        model.views = Int64(post.views)
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func toPost() -> Post {
        Post(
            author: author ?? "",
            image: image ?? "",
            description: descript ?? "",
            likes: Int(likes),
            views: Int(views)
        )
    }
}
