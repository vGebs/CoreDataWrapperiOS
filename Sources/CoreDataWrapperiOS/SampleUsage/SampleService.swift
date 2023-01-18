//
//  SampleService.swift
//  
//
//  Created by Vaughn on 2023-01-18.
//

import Foundation
import CoreData

class Task: NSManagedObject {
    @NSManaged var title: String
    @NSManaged var date: Date
    @NSManaged var notes: String
}

class TaskService {
    private let coreDataStack: CoreDataWrapper

    init(coreDataStack: CoreDataWrapper) throws {
        self.coreDataStack = coreDataStack
    }

    func fetchTasks() throws -> [Task] {
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        return try coreDataStack.fetch(fetchRequest: fetchRequest)
    }
    
    func createTask() -> Task {
        return coreDataStack.create(objectType: Task.self)
    }
    
    func delete(_ task: Task) throws {
        try coreDataStack.delete(object: task)
    }
    
    func save() throws {
        try coreDataStack.saveContext()
    }
}
