//
//  ChillEventViewModel.swift
//  Fuctivity
//
//  Created by Sosin Vladislav on 22.04.2023.
//

import Foundation
import CalendarKit
import UIKit


final class ChillEventViewModel {
    // MARK: - Properties
    private(set) var labelValue: Int {
        didSet {
            updateHoursLabelText()
        }
    }
    private(set) var currentDate: Date {
        didSet {
            updateDateLabelText()
        }
    }
    private(set) var dateLabelText: String = ""
    private(set) var hoursLabelText: String = ""
    
    // MARK: - Init
    init() {
        labelValue = Settings.sharedSettings.getRestHours()
        currentDate = Date()
        
        updateHoursLabelText()
        updateDateLabelText()
    }
    
    // MARK: - Public Methods
    func saveEventDescription(_ textView: String) {
        ChillEvent.eventDescription = textView
    }
    
    func saveCategory(_ textView: String) {
        ChillEvent.categoryOfEvent = textView
    }
    
    func getHours() -> Int {
        return ChillEvent.time
    }
    
    func increaseHours() {
        labelValue += 1
    }
    
    func decreaseHours() {
        labelValue -= 1
    }
    
    func setTime() {
        ChillEvent.time = labelValue
    }
    
    func setDate() {
        ChillEvent.date = dateLabelText
    }
    
    func nextDay() {
        let daysToAdd = 1
        var dateComponent = DateComponents()
        dateComponent.day = daysToAdd
        currentDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)!
    }
    
    func previousDay() {
        let daysToAdd = -1
        var dateComponent = DateComponents()
        dateComponent.day = daysToAdd
        currentDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)!
    }
    
    // MARK: - Private Methods
    private func updateHoursLabelText() {
        hoursLabelText = "\(labelValue) ч. отдыха"
    }
    
    private func updateDateLabelText() {
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: currentDate)
        dateLabelText = "\(calendarDate.day ?? 0) \(getMonthNameByNumber(calendarDate.month ?? 0)) \(calendarDate.year ?? 0)"
    }
    
    private func getMonthNameByNumber(_ number: Int) -> String {
        switch number {
        case 1:
            return "января"
        case 2:
            return "февраля"
        case 3:
            return "марта"
        case 4:
            return "апреля"
        case 5:
            return "мая"
        case 6:
            return "июня"
        case 7:
            return "июля"
        case 8:
            return "августа"
        case 9:
            return "сентября"
        case 10:
            return "октября"
        case 11:
            return "ноября"
        case 12:
            return "декабря"
        default:
            return ""
        }
    }
}
