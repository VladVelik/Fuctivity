//
//  ChillEvent.swift
//  Fuctivity
//
//  Created by Федор Филиппов on 10.12.2022.
//

import Foundation
import UIKit
import CalendarKit

final class ChillEvent {
    public static var time: Int = 0
    
    public static var date: String = String()
    public static var categoryOfEvent: String = String()
    public static var eventDescription: String = String()
    public static var eventStorage: [Event] = ChillEvent.getEvents()
    
    public static var days: String = ""
    
    public static var username = UserDefaults.standard.string(forKey: "username")
    public static var password = UserDefaults.standard.string(forKey: "password")
    public static var email = UserDefaults.standard.string(forKey: "email")
    
    public static var restHours: Int = UserDefaults.standard.integer(forKey: "restHours")
    
    public static var eventNumber = UserDefaults.standard.integer(forKey: "eventNumber")

    private static func getEvents() -> [Event] {
        var list: [Event] = []
        for i in 1...ChillEvent.eventNumber + 1 {
            let event: Event = Event()
            event.text = UserDefaults.standard.string(forKey: "eventText\(i)") ?? ""
            event.color = UIColor.UIColorFromRGB(rgbValue: 0xeb943d)
            event.lineBreakMode = .byTruncatingTail
            
            let obj1 = UserDefaults.standard.object(forKey: "startInterval\(i)")
            let obj2 = UserDefaults.standard.object(forKey: "endInterval\(i)")

            if obj1 != nil && obj2 != nil {
                event.dateInterval = DateInterval(start: obj1 as! Date, end: obj2 as! Date)
            }
            list.append(event)
        }
        return list
    }
}
