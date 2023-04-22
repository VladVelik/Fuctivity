//
//  StatisticsViewModel.swift
//  Fuctivity
//
//  Created by Nik Y on 22.04.2023.
//

import Foundation
import SwiftUI
import CalendarKit

class StatisticsViewModel: ObservableObject {
    @Published var data: [DailyDuration] = []
    
    func updateData() {
        getDailyDurations(week: 0)
    }
    
    struct DailyDuration: Identifiable {
        let id = UUID()
        let date: Date
        var duration: TimeInterval
        var animate: Bool = false
    }

    // Получение общей продолжительности событий для каждого дня недели для выбранной недели, где 0 - текущая неделя
    func getDailyDurations(week: Int) {
        let events = ChillEvent.eventStorage // Assuming ChillEvent.eventStorage contains the events
        
        let calendar = Calendar.current
        let now = Date()
        let currentWeekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
        let weekStart = calendar.date(
            byAdding: .day,
            value: 1,
            to: calendar.date(byAdding: .weekOfYear, value: week, to: currentWeekStart)!
        )!
        let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart)!

        var dailyDurations: [DailyDuration] = []

        // Initialize dailyDurations array with dates and zero durations
        for i in 0..<7 {
            let date = calendar.date(byAdding: .day, value: i, to: weekStart)!
            dailyDurations.append(DailyDuration(date: date, duration: 0))
        }

        for event in events {
            let startOfEvent = event.dateInterval.start
            
            if calendar.compare(startOfEvent, to: weekStart, toGranularity: .day) != .orderedAscending &&
                calendar.compare(startOfEvent, to: weekEnd, toGranularity: .day) != .orderedDescending {
                
                let dayOfWeek = calendar.component(.weekday, from: startOfEvent) - calendar.firstWeekday
                let adjustedDayOfWeek = (dayOfWeek + 6) % 7
                dailyDurations[adjustedDayOfWeek].duration += event.dateInterval.duration
            }
        }
        
        for i in 0..<7 {
            dailyDurations[i].duration = dailyDurations[i].duration / 3600
        }

        data = dailyDurations
    }
    
    func getWeekText(week: Int) -> String {
        let calendar = Calendar.current
        let now = Date()
        let currentWeekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
        let weekStart = calendar.date(
            byAdding: .day,
            value: 1,
            to: calendar.date(byAdding: .weekOfYear, value: week, to: currentWeekStart)!
        )!
        let weekEnd = calendar.date(byAdding: .day, value: 6, to: weekStart)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return "\(dateFormatter.string(from: weekStart)) - \(dateFormatter.string(from: weekEnd))"
    }
//
//    func getChartYScale(activityType: ActivityType) -> ClosedRange<Int> {
//        let dur = petViewModel.currentPet.animalType.getDuration(of: activityType)
//        let count = petViewModel.currentPet.animalType.getActivitiesFrequency(of: activityType).count
//        if petViewModel.currentPet.animalType.getActivitiesFrequency(of: activityType).unit == .day {
//            return 0...Int(dur*Double(count)*1.2)
//        }
//        return 0...Int(dur*1.2)
//    }
}

