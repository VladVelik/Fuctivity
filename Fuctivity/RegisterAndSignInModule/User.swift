//
//  User.swift
//  Fuctivity
//
//  Created by Kate on 21.04.2023.
//

import Foundation

class User{
    public static var sharedUser = User()
    private var loggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
    private var username = UserDefaults.standard.string(forKey: "username")
    private var password = UserDefaults.standard.string(forKey: "password")
    private var email = UserDefaults.standard.string(forKey: "email")
    private var restHours: Int = UserDefaults.standard.integer(forKey: "restHours")
    private var settings: Settings = Settings.sharedSettings
    
    public func checkLogin(username: String, password: String, email: String){
        if self.username == username && self.password == password && self.email == email{
            self.loggedIn = true;
            UserDefaults.standard.set(true, forKey: "loggedIn")
        }
        else{
            self.loggedIn = false;
            UserDefaults.standard.set(false, forKey: "loggedIn")
        }
    }
    public func register(username: String, password: String, email: String){
        self.username = username
        self.password = password
        self.email = email
        self.loggedIn = true;
        UserDefaults.standard.set(true, forKey: "loggedIn")
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(email, forKey: "email")
    }
    
    public func isLogin()-> Bool{
        return self.loggedIn
    }
}
