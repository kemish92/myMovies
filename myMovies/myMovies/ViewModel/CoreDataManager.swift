//
//  CoreDataManager.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/14/23.
//

import CoreData

class SessionManager {
    static let shared = SessionManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "myMovies")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func insertSessionId(id: String) {
        let entity = NSEntityDescription.entity(forEntityName: "SessionId", in: context)!
        let sessionId = NSManagedObject(entity: entity, insertInto: context)
        sessionId.setValue(id, forKeyPath: "idSession")
        saveContext()
    }
    
    func readSessionId() -> String? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SessionId")
        do {
            let result = try context.fetch(fetchRequest)
            if let session = result.first as? NSManagedObject,
               let id = session.value(forKey: "idSession") as? String {
                return id
            }
        } catch {
            print("Error reading session: \(error)")
        }
        return nil
    }
    
    func updateSessionId(newId: String) {
        if readSessionId() != nil {
            deleteSessionId() // Delete the existing session ID
        }
        insertSessionId(id: newId) // Insert the new session ID
    }
    
    func deleteSessionId() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SessionId")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
            saveContext()
        } catch {
            print("Error deleting session: \(error)")
        }
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}

