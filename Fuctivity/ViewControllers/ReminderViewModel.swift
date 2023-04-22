//
//  ReminderViewModel.swift
//  Fuctivity
//
//  Created by Sosin Vladislav on 22.04.2023.
//
import UIKit
import CalendarKit

final class ReminderViewModel {
    func createNotification(day: Int,
                            month: Int,
                            year: Int,
                            hour: Int,
                            minute: Int,
                            title: String,
                            body: String) {
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: body, arguments: nil)
        content.sound = UNNotificationSound.default
        content.badge = 1
        let identifier = UUID().uuidString
        
        var dateInfo = DateComponents()
        dateInfo.day = day
        dateInfo.month = month
        dateInfo.year = year
        dateInfo.hour = hour
        dateInfo.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            } else{
                print("send!!")
            }
        }
    }
}
