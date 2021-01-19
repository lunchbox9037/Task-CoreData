//
//  TaskController.swift
//  Task-CoreData
//
//  Created by stanley phillips on 1/19/21.
//

import CoreData

class TaskController {
    // MARK: - Properties
    static var shared = TaskController()
    var tasks: [Task] = []
    //create fetch request
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        //create and assign a fetch request that looks for medication objects
        let request = NSFetchRequest<Task>(entityName: "Task")
        //predicate allows you to specify(filter) which medication objects you want to fetch(ie: filter by specified arguments)
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        Task(name: name, notes: notes, dueDate: dueDate)
        CoreDataStack.saveContext()
    }
    
    func fetchTasks() {
        tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    func update(task: Task, with name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        CoreDataStack.saveContext()
    }
    
    func delete(task: Task) {
        guard let taskToDelete = tasks.firstIndex(of: task) else {return}
        tasks.remove(at: taskToDelete)
        CoreDataStack.context.delete(task)
        CoreDataStack.saveContext()
    }
}

