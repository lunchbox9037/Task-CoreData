//
//  Notifications.swift
//  Task-CoreData
//
//  Created by stanley phillips on 1/19/21.
//

import UserNotifications

class NotificationScheduler {
    func scheduleNotification(task: Task) {
        guard let dueDate = task.dueDate,
              let name = task.name,
              let id = task.id else {return}
        
        //create the notification center
        let center = UNUserNotificationCenter.current()
        
        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = "Time to \(name)."
        content.body = "Mark as done?"
        content.sound = UNNotificationSound.default
        
        //create the trigger date
        let triggerDate = Calendar.current.dateComponents([.day, .hour, .minute], from: dueDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        //create the request and add it to the notification center
        let request = UNNotificationRequest(identifier: "\(id)", content: content, trigger: trigger)
        center.add(request)
    }
    
    func cancelNotification(task: Task) {
        guard let id = task.id else {return}
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
