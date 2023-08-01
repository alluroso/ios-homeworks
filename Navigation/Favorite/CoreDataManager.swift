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
        persistentContainer.performBackgroundTask { backgroundContext in
            if self.getPost(image: post.image, context: backgroundContext) != nil
            { return }
            Model.create(with: post, using: backgroundContext)
        }
    }
    
    func showFavorites(author: String? = nil) -> [Post] {
        let request = Model.fetchRequest()
        if let author = author, author != "" {
            request.predicate = NSPredicate(format: "author contains[c] %@", author)
        }
        guard let fetchRequestResult = try? persistentContainer.viewContext.fetch(request) else { return [] }
        return fetchRequestResult.map { $0.toPost() }
    }
    
    func getPost(image: String, context: NSManagedObjectContext) -> Model? {
        let request = Model.fetchRequest()
        request.predicate = NSPredicate(format: "image == %@", image)
        return (try? context.fetch(request))?.first
    }
    
    func deletePost(_ post: Post) {
        let context = persistentContainer.viewContext
        if let post = getPost(image: post.image, context: context) {
            context.delete(post)
            saveContext()
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
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
    
    static func delete(with post: Post, using context: NSManagedObjectContext) {
        let model = Model(context: context)
        model.title = post.title
        model.author = post.author
        model.descript = post.description
        model.image = post.image
        model.likes = Int64(post.likes)
        model.views = Int64(post.views)
        
        context.delete(model)
        saveContext(context)
    }
    
    static func saveContext(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
