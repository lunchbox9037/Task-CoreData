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
    var sectionedTasks: [[Task]] {[incompleteTasks, completeTasks]}
    var completeTasks: [Task] = []
    var incompleteTasks: [Task] = []
    
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
        let newTask = Task(name: name, notes: notes, dueDate: dueDate)
        incompleteTasks.append(newTask)
        
        CoreDataStack.saveContext()
    }
    
    func fetchTasks() {
        let tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        completeTasks = tasks.filter({$0.isComplete})
        incompleteTasks = tasks.filter({!$0.isComplete})
    }
    
    func update(task: Task, with name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        CoreDataStack.saveContext()
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        if task.isComplete {
            if let taskToToggle = incompleteTasks.firstIndex(of: task) {
                incompleteTasks.remove(at: taskToToggle)
                completeTasks.append(task)
            }
        } else {
            if let taskToToggle = completeTasks.firstIndex(of: task) {
                completeTasks.remove(at: taskToToggle)
                incompleteTasks.append(task)
            }
        }
        CoreDataStack.saveContext()
    }
    
    func delete(task: Task) {
        if task.isComplete {
            guard let taskToDelete = completeTasks.firstIndex(of: task) else {return}
            completeTasks.remove(at: taskToDelete)
        } else {
            guard let taskToDelete = incompleteTasks.firstIndex(of: task) else {return}
            incompleteTasks.remove(at: taskToDelete)
        }
        CoreDataStack.context.delete(task)
        CoreDataStack.saveContext()
    }
}

