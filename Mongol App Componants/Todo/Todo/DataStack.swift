import CoreData

// defines Core Data Stack
class Stack {
    
    let model: NSManagedObjectModel! // database scheme or model
    let coordinator: NSPersistentStoreCoordinator! // writes data to store
    let store: NSPersistentStore! // the storate (database)
    let context: NSManagedObjectContext!
    
    init() {
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("awesomeAppModel", withExtension: "momd")!
        self.model = NSManagedObjectModel(contentsOfURL: modelURL)
        self.coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.model)
        
        // store
        let fileManager = NSFileManager.defaultManager()
        let URLS = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) 
        let documentsDirectory = URLS[0]
        let storeURL = documentsDirectory.URLByAppendingPathComponent("Todo.sqlite")
        try! self.store = coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        
        // managed object context
        self.context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        self.context.persistentStoreCoordinator = self.coordinator
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            }catch{
                print(error)
            }
        }
        
    }
}