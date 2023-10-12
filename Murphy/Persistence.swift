//
//  Persistence.swift
//  Murphy
//
//  Created by Bartu Kara on 3.10.2023.
//

import CoreData

struct PersistenceController {
    
    // MARK: - 1.Persistent Controller
    
    static let shared = PersistenceController()
    
    // MARK: -  2. Persistent Container
    
    let container: NSPersistentContainer
    
    
    // MARK: - 3. Initialization (load the presisrent store)
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Murphy")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    

    // MARK: -  4. Preview
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let newItem = FreelanceData(context: viewContext)
        for _ in 0..<10 {
            //newItem.timestamp = Date()
            //newItem.name = "Merhaba"
            //newItem.time = 0.0
            //newItem.id = UUID()
        }
        do {
            try viewContext.save()
        } catch {
            
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    

    
}
