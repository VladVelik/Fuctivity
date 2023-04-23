//
//  ReminderViewController.swift
//  Fuctivity
//
//  Created by Федор Филиппов on 11.12.2022.
//

import UIKit
import CalendarKit

final class ReminderViewController: UIViewController {
    // MARK: - Public Properties
    let hourLabel = UIButton()
    let continueButton = UIButton()
    let timeLabel = UILabel()
    let reminderLabel = UILabel()
    private let viewModel = ChillEventViewModel()
    private let rViewModel = ReminderViewModel()
    
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
        rViewModel.continueAction(datePicker, startTimePicker, reminderTimePicker)
        navigationController?.popToRootViewController(animated: true)
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
