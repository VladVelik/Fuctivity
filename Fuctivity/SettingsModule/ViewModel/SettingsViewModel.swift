//
//  SettingsViewModel.swift
//  Fuctivity
//
//  Created by Kate on 21.04.2023.
//

import Foundation

class SettingsViewModel{
    
    public func setRestHours(restHours: Int){
        if restHours < 24 && restHours >= 0{
            Settings.sharedSettings.setRestHours(restHours: restHours)
            UserDefaults.standard.set(restHours, forKey: "restHours")
        }
    }
    
    public func setWorkHours(workHours: Int){
        if workHours < 24 && workHours >= 0{
            Settings.sharedSettings.setWorkHours(workHours: workHours)
            UserDefaults.standard.set(workHours, forKey: "workHours")
        }
    }
    
    public func setDays(days: String){
        Settings.sharedSettings.setDays(days: days)
        UserDefaults.standard.set(days, forKey: "workDays")
    }
    
    public func plusRestHours(restHours: Int) -> String{
        if restHours > 10 {
            return "6"
        }
        if restHours >= 0 && restHours < 10 {
            return String(restHours + 1)
        }
        return "6"
    }
    
    public func minusRestHours(restHours: Int) -> String{
        if restHours > 10 {
            return "6"
        }
        if restHours >= 2 && restHours < 11 {
            return String(restHours - 1)
        }
        return "6"
    }
    
    public func plusWorkHours(workHours: Int) -> String{
        if workHours > 12 {
            return "8"
        }
        if workHours >= 0 && workHours < 12 {
            return String(workHours + 1)
        }
        return "8"
    }
    
    public func minusWorkHours(workHours: Int) -> String{
        if workHours > 12 {
            return "8"
        }
        if workHours >= 2 && workHours < 13 {
            return String(workHours - 1)
        }
        return "8"
    }

}
