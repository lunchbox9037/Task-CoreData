//
//  Notifications.swift
//  Task-CoreData
//
//  Created by stanley phillips on 1/19/21.
//

import UIKit

extension UIViewController {
    func scheduleNotification(taskName: String, dueDate: Date) {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Your task is due."
        content.body = "Mark \(taskName) as done?"
        content.sound = UNNotificationSound.default
        
        let date = dueDate
        let triggerDate = Calendar.current.dateComponents([.day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
