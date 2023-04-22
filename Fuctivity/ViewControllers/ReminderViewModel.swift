//
//  ReminderViewModel.swift
//  Fuctivity
//
//  Created by Sosin Vladislav on 22.04.2023.
//
import UIKit
import CalendarKit

final class ReminderViewModel {
    struct Reminder {
        let date: Date
        let startTime: Date
        let endTime: Date
        let reminderTime: Date
    }
    
    func createReminder(reminder: Reminder) {
        let event = Event()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let year = formatter.string(from: reminder.date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: reminder.date)
        formatter.dateFormat = "dd"
        let day = formatter.string(from: reminder.date)

        let someDateTimeStart = formatter.date(from: "\(year)/\(month)/\(day) \(formatter.string(from: reminder.startTime))")!
        
        let endHour = Calendar.current.component(.hour, from: reminder.startTime) + ChillEvent.time
        
        let endDateTimeString = "\(year)/\(month)/\(day) \(endHour % 24):\(formatter.string(from: reminder.startTime))"
        let someDateTimeEnd = formatter.date(from: endDateTimeString)!
        
        event.dateInterval = DateInterval(start: someDateTimeStart, end: someDateTimeEnd)
        event.text = ChillEvent.eventDescription
        event.color = UIColor.UIColorFromRGB(rgbValue: 0xeb943d)
        event.lineBreakMode = .byTruncatingTail

        ChillEvent.eventStorage.append(event)
        ChillEvent.eventNumber += 1
        
        UserDefaults.standard.set(event.text, forKey: "eventText\(ChillEvent.eventNumber)")
        UserDefaults.standard.set(event.dateInterval.start, forKey: "startInterval\(ChillEvent.eventNumber)")
        UserDefaults.standard.set(event.dateInterval.end, forKey: "endInterval\(ChillEvent.eventNumber)")
        UserDefaults.standard.set(ChillEvent.eventNumber, forKey: "eventNumber")
        
        createNotification(date: reminder.reminderTime,
                           title: "Надеюсь, вы хорошо проводите время!",
                           body: "Оцените текущий отдых для создания статистики")
    }
    
    private func createNotification(date: Date, title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: body, arguments: nil)
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            } else{
                print("Notification scheduled successfully")
            }
        }
    }
    
    func getHours() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentDate = dateFormatter.string(from: Date())
        
        let hoursText = "До конца рабочего дня осталось\n\(ChillEvent.time) часов"
        
        return "\(currentDate)\n\(hoursText)"
    }
}
