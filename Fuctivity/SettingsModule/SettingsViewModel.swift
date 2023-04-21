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
        }
    }
    
    public func setWorkHours(workHours: Int){
        if workHours < 24 && workHours >= 0{
            Settings.sharedSettings.setWorkHours(workHours: workHours)
        }
    }
    
    public func setDays(days: String){
        Settings.sharedSettings.setDays(days: days)
    }
}
