//
//  DataBaseController.swift
//  ProjetoFinal
//
//  Created by Marilise Morona on 28/10/21.
//

import Foundation
import CoreData

class DataBaseController {
    
    // MARK: - Core Data stack
    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PokemonData")
        container.loadPersistentStores(completionHandler: { (storeDeion, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    static func saveContext () {
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
