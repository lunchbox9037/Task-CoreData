//
//  DateFormatterExtension.swift
//  Task-CoreData
//
//  Created by stanley phillips on 1/19/21.
//

import Foundation

extension DateFormatter {
    static let dueDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}
