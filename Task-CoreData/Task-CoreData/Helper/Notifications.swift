//
//  Notifications.swift
//  Task-CoreData
//
//  Created by stanley phillips on 1/19/21.
//

import UIKit

extension UIViewController {
    public func simpleAddNotification() {
        // Initialize User Notification Center Object
        let center = UNUserNotificationCenter.current()

        // The content of the Notification
        let content = UNMutableNotificationContent()
        content.title = "Time is up!"
        content.body = "Complete your task."
        content.sound = .default

        // The selected time to notify the user
//        var dateComponents = DateComponents()
//        dateComponents.calendar = Calendar.current
//        dateComponents.hour = hour
//        dateComponents.minute = minute

        // The time/repeat trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: true)

        // Initializing the Notification Request object to add to the Notification Center
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // Adding the notification to the center
        center.add(request) { (error) in
            if (error) != nil {
                print(error!.localizedDescription)
            }
        }
    }
}
