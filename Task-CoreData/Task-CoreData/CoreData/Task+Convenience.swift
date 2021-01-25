//
//  Task+Convenience.swift
//  Task-CoreData
//
//  Created by stanley phillips on 1/19/21.
//

import CoreData

extension Task {
    @discardableResult convenience init(project: Project, name: String, notes: String?, dueDate: Date?, id: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.project = project
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.id = id
    }
}


