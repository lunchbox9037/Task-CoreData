//
//  ProjectController.swift
//  Task-CoreData
//
//  Created by stanley phillips on 1/20/21.
//

import Foundation
import CoreData

class ProjectController {
    // MARK: - Properties
    static let shared = ProjectController()
    
    // MARK: - Source of Truth
    var projects: [Project] {(try? CoreDataStack.context.fetch(fetchRequest)) ?? []}
    
    private lazy var fetchRequest: NSFetchRequest<Project> = {
        let request = NSFetchRequest<Project>(entityName: "Project")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD
    func createProjectWith(name: String) {
        Project(name: name)
        CoreDataStack.saveContext()
    }
    
    func delete(project: Project) {
        CoreDataStack.context.delete(project)
        CoreDataStack.saveContext()
    }
}
