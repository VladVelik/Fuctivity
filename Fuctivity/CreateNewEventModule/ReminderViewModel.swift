//
//  ReminderViewModel.swift
//  Fuctivity
//
//  Created by Sosin Vladislav on 22.04.2023.
//
import UIKit
import CalendarKit

final class ReminderViewModel {
    func continueAction(_ datePicker: UIDatePicker,
                        _ startTimePicker: UIDatePicker,
                        _ reminderTimePicker: UIDatePicker) {
        var formatter = DateFormatter()

        let date = datePicker.date
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        formatter.dateFormat = "dd"
        var day = formatter.string(from: date)

        let event = Event()

        // TODO: fix next day event bug
        formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTimeStart = formatter
            .date(from: "\(year)/\(month)/\(day) \(startTimePicker.calendar.component(.hour, from: startTimePicker.date)):\(startTimePicker.calendar.component(.minute, from: startTimePicker.date))")!
        
        let endHour = (startTimePicker.calendar.component(.hour, from: startTimePicker.date) + ChillEvent.time)
        
        if endHour > 24 {
            let increment = endHour / 24
            let dayInt = Int(day)! + increment
            
            day = String(dayInt)
        }

        let someDateTimeEnd = formatter
            .date(from: "\(year)/\(month)/\(day) \(endHour % 24):\(startTimePicker.calendar.component(.minute, from: startTimePicker.date))")!

        event.dateInterval = DateInterval(start: someDateTimeStart, end: someDateTimeEnd)

        event.text = ChillEvent.eventDescription
        event.color = UIColor.UIColorFromRGB(rgbValue: 0xeb943d)
        event.lineBreakMode = .byTruncatingTail

        UserViewModel.shared.currentUser.addEvent(event)
        
        ChillEvent.eventNumber += 1
        
        UserDefaults.standard.set(event.text, forKey: "eventText\(ChillEvent.eventNumber)")
        
        UserDefaults.standard.set(event.dateInterval.start, forKey: "startInterval\(ChillEvent.eventNumber)")
        UserDefaults.standard.set(event.dateInterval.end, forKey: "endInterval\(ChillEvent.eventNumber)")
        
        UserDefaults.standard.set(ChillEvent.eventNumber, forKey: "eventNumber")
        
        createNotification(day: Int(day)!,
                           month: Int(month)!,
                           year: Int(year)!,
                           hour: startTimePicker.calendar.component(.hour, from: startTimePicker.date),
                           minute: startTimePicker.calendar.component(.minute, from: startTimePicker.date),
                           title: "Время отдыхать!",
                           body: "Думаем, вы уже хорошо поработали. А на сейчас запланирован отдых!")
        
        createNotification(day: Int(day)!,
                           month: Int(month)!,
                           year: Int(year)!,
                           hour: reminderTimePicker.calendar.component(.hour, from: reminderTimePicker.date),
                           minute: reminderTimePicker.calendar.component(.minute, from: reminderTimePicker.date),
                           title: "Надеюсь, вы хорошо проводите время!",
                           body: "Оцените текущий отдых для создания статистики")
        
    }
    
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
