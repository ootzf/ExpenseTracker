//
//  CoreDataManager.swift
//  ExpenseTracker
//
//  Created by ZhenFung Oot on 8/9/21.
//

//
//  CoreDataManager.swift
//  AppAnalytics
//
//  Created by ZhenFung Oot on 5/19/21.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ExpenseModel")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func loadExpenses() -> [ExpenseEntry] {
        let mainContext = CoreDataManager.shared.mainContext
        let fetchRequest: NSFetchRequest<ExpenseEntry> = ExpenseEntry.fetchRequest()
        do {
            let results = try mainContext.fetch(fetchRequest)
            return results
        }
        catch {
            debugPrint(error)
        }
        return []
    }
    
    func getEventSize() -> Int {
        let mainContext = CoreDataManager.shared.mainContext
        let fetchRequest: NSFetchRequest<ExpenseEntry> = ExpenseEntry.fetchRequest()
        do {
            let results = try mainContext.fetch(fetchRequest)
            return results.count
        }
        catch {
            debugPrint(error)
        }
        return 0
    }
    
    //not request, but parameter
    func saveEvent(name: String, amount: Double) {
        do {
            let context = CoreDataManager.shared.mainContext
            let expense = ExpenseEntry(context: context)
            expense.name = name
            expense.amount = amount
            try context.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    func deleteOneExpense(objectId: NSManagedObjectID) {
        let mainContext = CoreDataManager.shared.mainContext
        do {
            let object = try mainContext.existingObject(with: objectId)
            mainContext.delete(object)
            try mainContext.save()
        }
        catch let error as NSError {
            print(error)
        }
    }
    
    func deleteAllEvents() {
        let mainContext = CoreDataManager.shared.mainContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ExpenseEntry")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            let _ = try mainContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
}
