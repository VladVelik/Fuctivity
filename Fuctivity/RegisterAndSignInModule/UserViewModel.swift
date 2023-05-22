//
//  UserViewModel.swift
//  Fuctivity
//
//  Created by Kate on 21.04.2023.
//

import Foundation
import CryptoKit
import CalendarKit
import UIKit
class UserViewModel{
    static public var shared = UserViewModel()
    private(set) var currentUser: User = User()
    
    var delegate: UpdateRootController?

    
    init() {
        downloadEvents()
    }
    
    public func login(username: String, password: String, email: String){
        let hashpassword = passwordHash(email: email, password: password)
        if currentUser.getUsername() == username && currentUser.getHashPassword() == hashpassword && currentUser.getEmail() == email {
            currentUser.setLoggedIn(logIn: true)
            UserDefaults.standard.set(true, forKey: "loggedIn")
            delegate?.setCalendarController()

        }
        else{
            //currentUser.setLoggedIn(logIn: true)
            //UserDefaults.standard.set(true, forKey: "loggedIn")
           currentUser.setLoggedIn(logIn: false)
           UserDefaults.standard.set(false, forKey: "loggedIn")
        }
    }
    
    public func isLogin() -> Bool{
        return currentUser.getIsLogged()
    }
    
    public func register(username: String, password: String, email: String){
        if username.isEmpty || password.isEmpty || email.isEmpty{
            return
        }
        delegate?.setCalendarController()
        let hashpassword = passwordHash(email: email, password: password)
        UserDefaults.standard.set(true, forKey: "loggedIn")
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(hashpassword, forKey: "password")
        UserDefaults.standard.set(email, forKey: "email")
        currentUser.register(username: username, password: hashpassword, email: email)
    }
    
    func passwordHash(email: String, password: String) -> String {
        let salt = "x4vV8bGgqqmQwgCoyXFQj+(o.nUNQhVP7ND"
        return SHA256.hash(data: Data("\(password).\(email).\(salt)".utf8)).description
    }
    
    private func downloadEvents() {
//        let calendar = Calendar.current
//        let now = Date()
//        let startOfDay = calendar.startOfDay(for: now)
//
//        var events: [Event] = []
//
//        for day in -15...15 {
//            let eventDate = calendar.date(byAdding: .day, value: day, to: startOfDay)!
//            let startDate = eventDate.addingTimeInterval(TimeInterval(60 * 60 * 6))
//            let randomHour = Int.random(in: 0...12)
//            let endDate = startDate.addingTimeInterval(TimeInterval(60*60*randomHour))
//
//            let event = Event()
//            event.text = "test"
//            event.color = UIColor.UIColorFromRGB(rgbValue: 0xeb943d)
//            event.lineBreakMode = .byTruncatingTail
//            event.dateInterval = DateInterval(start: startDate, end: endDate)
//            events.append(event)
//        }
//
//        currentUser.setEvents(events)
        
        var events: [Event] = []
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
            events.append(event)
        }
        currentUser.setEvents(events)
    }
}
