//
//  SampleViewModel.swift
//  
//
//  Created by Vaughn on 2023-01-18.
//

import Foundation
import Combine

@available(iOS 13.0, *)
class TaskViewModel: ObservableObject {
    private let taskService: TaskService
    @Published private(set) var tasks: [Task] = []
    
    init() {
        do {
            let storeURL = try! FileManager.default
                    .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    .appendingPathComponent("TaskModel.sqlite")
            let coreDataStack = CoreDataWrapper(modelName: "TaskModel", storeURL: storeURL)
            self.taskService = try TaskService(coreDataStack: coreDataStack)
        } catch {
            fatalError("Error initializing TaskService: \(error)")
        }
    }
    
    func fetchTasks() {
        do {
            tasks = try taskService.fetchTasks()
            print("Tasks fetched")
        } catch {
            fatalError("Error fetching tasks: \(error)")
        }
    }
    
    func createTask(title: String, date: Date, notes: String) {
        let newTask = taskService.createTask()
        newTask.title = title
        newTask.date = date
        newTask.notes = notes
        tasks.append(newTask)
        save()
        print("Created task")
    }
    
    func edit(task: Task, title: String, date: Date, notes: String) {
        task.title = title
        task.date = date
        task.notes = notes
        save()
    }
    
    func delete(task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks.remove(at: index)
        }
        do {
            try taskService.delete(task)
            save()
            print("Removed task")
        } catch {
            fatalError("Error deleting task: \(error)")
        }
    }
    
    private func save() {
        do {
            try taskService.save()
        } catch {
            fatalError("Error saving context: \(error)")
        }
    }
}
