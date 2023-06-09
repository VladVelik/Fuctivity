//
//  User.swift
//  Fuctivity
//
//  Created by Kate on 21.04.2023.
//

import Foundation
import CalendarKit
import UIKit

class User {
    private var loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
    private var username = UserDefaults.standard.string(forKey: "username") ?? ""
    private var hashPassword = UserDefaults.standard.string(forKey: "password") ?? ""
    private var email = UserDefaults.standard.string(forKey: "email") ?? ""
    private var settings: Settings = Settings.sharedSettings
    private(set) var eventStorage: [Event] = []
    
    public func register(username: String, password: String, email: String){
        self.username = username
        self.hashPassword = password
        self.email = email
        self.loggedIn = true;
    }
    
    public func setLoggedIn(logIn: Bool){
        self.loggedIn = logIn
    }
    
    public func getIsLogged()-> Bool{
        return self.loggedIn
    }
    
    public func getUsername() -> String{
        return self.username
    }
    
    public func getHashPassword() -> String{
        return self.hashPassword
    }
    
    public func getEmail() -> String{
        return self.email
    }
    
    public func setEvents(_ events: [Event]) {
        self.eventStorage = events
    }
    
    public func addEvent(_ event: Event) {
        self.eventStorage.append(event)
    }
}
