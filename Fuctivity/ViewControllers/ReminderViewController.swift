//
//  ReminderViewController.swift
//  Fuctivity
//
//  Created by Федор Филиппов on 11.12.2022.
//

import Foundation
import UIKit
import CalendarKit

final class ReminderViewController: UIViewController {
    // MARK: - Public Properties
    let hourLabel = UIButton()
    let continueButton = UIButton()
    let timeLabel = UILabel()
    let reminderLabel = UILabel()
    private let viewModel = ChillEventViewModel()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = .orange
        datePicker.backgroundColor = UIColor.UIColorFromRGB(rgbValue: 0xf1ebfa)
        return datePicker
    }()
    
    let startTimePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = .orange
        datePicker.backgroundColor = UIColor.UIColorFromRGB(rgbValue: 0xf1ebfa)
        return datePicker
    }()
    
    let endTimePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = .orange
        datePicker.backgroundColor = UIColor.UIColorFromRGB(rgbValue: 0xf1ebfa)
        
        datePicker.date = Calendar.current.date(byAdding: .hour, value: ChillEvent.time, to: Date())!
        
        return datePicker
    }()
    
    let reminderTimePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = .orange
        datePicker.backgroundColor = UIColor.UIColorFromRGB(rgbValue: 0xf1ebfa)
        return datePicker
    }()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupHoursLabel()
        setupContinueButton()
        setupLabels()
        setupDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hourLabel.setTitle(viewModel.getHours(), for: .normal)
    }
    
    // MARK: - private Methods
    private func setupHoursLabel() {
        self.view.addSubview(hourLabel)
        hourLabel.setTitle(viewModel.getHours(), for: .normal)
        hourLabel.setHeight(to: 40)
        hourLabel.setTitleColor(.white, for: .normal)
        hourLabel.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        hourLabel.backgroundColor = UIColor.UIColorFromRGB(rgbValue: 0xaf95fc)
        hourLabel.layer.cornerRadius = 12
        hourLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        hourLabel.pinLeft(to: self.view.leadingAnchor, 20)
        hourLabel.pin(to: self.view, [.left: 20, .right: 160])
    }
    
    private func setupContinueButton() {
        self.view.addSubview(continueButton)
        
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        continueButton.backgroundColor = UIColor.UIColorFromRGB(rgbValue: 0xaf95fc)
        continueButton.layer.cornerRadius = 12
        continueButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, 90)
        continueButton.pin(to: self.view, [.left: 90, .right: 90])
    }
    
    @objc
    private func continueAction() {
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

        ChillEvent.eventStorage.append(event)
        
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
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func createNotification(day: Int,
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
    
    private func setupLabels() {
        self.view.addSubview(timeLabel)
        self.view.addSubview(reminderLabel)
        
        timeLabel.text = "Время"
        timeLabel.textColor = .black
        timeLabel.font = .systemFont(ofSize: 30, weight: .bold)
        timeLabel.pinTop(to: hourLabel.bottomAnchor, 30)
        timeLabel.pinLeft(to: self.view.leadingAnchor, 20)
        timeLabel.pin(to: self.view, [.left: 20, .right: 160])
    }
    
    private func setupDatePicker() {
        self.view.addSubview(datePicker)
        self.view.addSubview(startTimePicker)
        self.view.addSubview(endTimePicker)
        self.view.addSubview(reminderTimePicker)
        
        let dateLabel = UILabel()
        let startTimeLabel = UILabel()
        let endTimeLabel = UILabel()
        let reminderTimeLabel = UILabel()
        
        self.view.addSubview(dateLabel)
        self.view.addSubview(startTimeLabel)
        self.view.addSubview(endTimeLabel)
        self.view.addSubview(reminderTimeLabel)
        
        dateLabel.text = "Дата"
        startTimeLabel.text = "Время начала"
        endTimeLabel.text = "Время окончания"
        reminderTimeLabel.text = "Об окончании"
        
        dateLabel.pinLeft(to: self.view.leadingAnchor, 30)
        dateLabel.pinTop(to: timeLabel.bottomAnchor, 30)
        
        datePicker.pinTop(to: dateLabel.bottomAnchor, 15)
        datePicker.pinLeft(to: self.view.leadingAnchor, 30)
        
        startTimeLabel.pinTop(to: datePicker.bottomAnchor, 15)
        startTimeLabel.pinLeft(to: self.view.leadingAnchor, 30)
        
        startTimePicker.pinTop(to: startTimeLabel.bottomAnchor, 15)
        startTimePicker.pinLeft(to: self.view.leadingAnchor, 30)
        
        endTimeLabel.pinTop(to: startTimePicker.bottomAnchor, 15)
        endTimeLabel.pinLeft(to: self.view.leadingAnchor, 30)
        
        endTimePicker.pinTop(to: endTimeLabel.bottomAnchor, 15)
        endTimePicker.pinLeft(to: self.view.leadingAnchor, 30)
        
        reminderTimePicker.pinBottom(to: continueButton.topAnchor, 50)
        reminderTimePicker.pinLeft(to: self.view.leadingAnchor, 30)
        
        reminderTimeLabel.pinLeft(to: self.view.leadingAnchor, 30)
        reminderTimeLabel.pinBottom(to: reminderTimePicker.topAnchor, 15)
        
        reminderLabel.text = "Напоминания"
        reminderLabel.textColor = .black
        reminderLabel.font = .systemFont(ofSize: 30, weight: .bold)
        reminderLabel.pinLeft(to: self.view.leadingAnchor, 20)
        reminderLabel.pinBottom(to: reminderTimeLabel.topAnchor, 30)
    }
}
