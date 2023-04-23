//
//  ChillEvent.swift
//  Fuctivity
//
//  Created by Федор Филиппов on 10.12.2022.
//

import Foundation

final class ChillEvent {
    public static var time: Int = 0
    public static var date: String = String()
    public static var categoryOfEvent: String = String()
    public static var eventDescription: String = String()
    public static var eventNumber = UserDefaults.standard.integer(forKey: "eventNumber")
}
