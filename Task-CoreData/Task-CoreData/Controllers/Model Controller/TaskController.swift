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
    let notificationScheduler = NotificationScheduler()
    
    var sectionedTasks: [[Task]] {[incompleteTasks, completeTasks]}
    var completeTasks: [Task] = []
    var incompleteTasks: [Task] = []
    
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD
    func createTaskFor(project: Project, name: String, notes: String?, dueDate: Date?) {
        let newTask = Task(project: project, name: name, notes: notes, dueDate: dueDate)
        incompleteTasks.append(newTask)
        CoreDataStack.saveContext()
        notificationScheduler.scheduleNotification(task: newTask)
    }
    
    func fetchTasks(project: Project) {
        let tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        let projectTasks = tasks.filter { (task) -> Bool in
            //returns only the tasks for a specific project
            return task.project == project
        }
        //filters the tasks by completed and not completed
        completeTasks = projectTasks.filter({$0.isComplete})
        incompleteTasks = projectTasks.filter({!$0.isComplete})
    }
    
    func update(task: Task, with name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.notes = notes
        task.dueDate = dueDate
        CoreDataStack.saveContext()
        notificationScheduler.cancelNotification(task: task)
        notificationScheduler.scheduleNotification(task: task)
    }
    
    func toggleIsComplete(task: Task) {
        task.isComplete.toggle()
        if let taskToToggle = incompleteTasks.firstIndex(of: task) {
            incompleteTasks.remove(at: taskToToggle)
            completeTasks.append(task)
            notificationScheduler.cancelNotification(task: task)
        } else if let taskToToggle = completeTasks.firstIndex(of: task) {
            completeTasks.remove(at: taskToToggle)
            incompleteTasks.append(task)
            notificationScheduler.scheduleNotification(task: task)
        }
        CoreDataStack.saveContext()
    }
    
    func delete(task: Task) {
        if let taskToDelete = completeTasks.firstIndex(of: task) {
            completeTasks.remove(at: taskToDelete)
        } else if let taskToDelete = incompleteTasks.firstIndex(of: task) {
            incompleteTasks.remove(at: taskToDelete)
        }
        notificationScheduler.cancelNotification(task: task)
        CoreDataStack.context.delete(task)
        CoreDataStack.saveContext()
    }
}

