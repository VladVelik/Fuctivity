//
//  Settings.swift
//  Fuctivity
//
//  Created by Kate on 21.04.2023.
//

import Foundation

class Settings{
    public static var sharedSettings = Settings()
    
    private var days = UserDefaults.standard.string(forKey: "workDays") ?? ""
    
    private var restHours: Int = UserDefaults.standard.integer(forKey: "restHours")
    
    private var workHours: Int = UserDefaults.standard.integer(forKey: "workHours")
    
    public func setRestHours(restHours: Int){
        self.restHours = restHours
        
    }
    
    public func setWorkHours(workHours: Int){
        self.workHours = workHours
    }
    
    public func setDays(days: String){
        self.days = days
    }
    
    public func getRestHours() -> Int{
        return restHours
    }
    
    public func getWorkHours() -> Int{
        return workHours
    }
    
    public func getDays() -> String{
        return days
    }
}
