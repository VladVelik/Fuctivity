//
//  ChillHourViewController.swift
//  Fuctivity
//
//  Created by Федор Филиппов on 10.12.2022.
//

import Foundation
import UIKit

final class ChillHourViewController: UIViewController {
    // MARK: - Public Properties
    var hoursLabel = UILabel()
    var labelValue = Int()
    
    let buttonIncrease = UIButton()
    let buttonDecrease = UIButton()
    
    var currentDate = Date()
    let dateLabel = UILabel()
    
    let categoryDescriptionViewController = CategoryDescriptionViewController()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayer()
        continueButtonSetup()
        setupDatePicker()
        
        currentDate = Date()
        labelValue = ChillEvent.restHours
        self.view.addSubview(hoursLabel)
        hoursLabel.text = "\(labelValue) ч. отдыха"
        hoursLabel.pinCenter(to: self.view.centerXAnchor)
        hoursLabel.pinBottom(to: self.view.centerYAnchor)
        hoursLabel.font = .systemFont(ofSize: 40, weight: .bold)
        hoursLabel.textColor = .black
        
        self.view.addSubview(buttonIncrease)
        self.view.addSubview(buttonDecrease)
        
        buttonIncrease.pinCenter(to: self.view.centerXAnchor)
        buttonIncrease.pinBottom(to: hoursLabel.topAnchor, 25)
        
        buttonIncrease.isEnabled = false
        
        buttonDecrease.pinCenter(to: self.view.centerXAnchor)
        buttonDecrease.pinTop(to: hoursLabel.bottomAnchor, 25)
        
        let image1 = UIImage(systemName: "arrowtriangle.up.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let image2 = UIImage(systemName: "arrowtriangle.down.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        buttonIncrease.setImage(image1, for: .normal)
        buttonDecrease.setImage(image2, for: .normal)
        
        buttonIncrease.addTarget(self, action: #selector(increaseHours), for: .touchUpInside)
        buttonDecrease.addTarget(self, action: #selector(decreaseHours), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentDate = Date()
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: currentDate)
        dateLabel.text = "\(calendarDate.day ?? 0) \(getMonthNameByNumber(calendarDate.month ?? 0)) \(calendarDate.year ?? 0)"
    }
    
    // MARK: - Private Methods (place certain items on the storyboard)
    func setupLayer() {
        let layer = CAGradientLayer()
        
        layer.colors = [UIColor.UIColorFromRGB(rgbValue: 0xaf95fc).cgColor,
                        UIColor.UIColorFromRGB(rgbValue: 0xaf95fc).cgColor,
                        UIColor.white.cgColor,
                        UIColor.white.cgColor]
        
        layer.locations = [NSNumber(value: 0.0),
                           NSNumber(value: 0.2),
                           NSNumber(value: 0.2),
                           NSNumber(value: 1.0)]
        
        layer.frame = view.frame
        view.layer.insertSublayer(layer, at: 0)
    }
    
    func continueButtonSetup() {
        let continueButton = UIButton()
        self.view.addSubview(continueButton)
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        continueButton.backgroundColor = UIColor.UIColorFromRGB(rgbValue: 0xaf95fc)
        continueButton.layer.cornerRadius = 12
        continueButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, 90)
        continueButton.pin(to: self.view, [.left: 90, .right: 90])
    }
    
    // MARK: - Work with actions
    @objc
    private func continueAction() {
        self.navigationController?.pushViewController(self.categoryDescriptionViewController,
                                                      animated: true)
        ChillEvent.time = labelValue
        ChillEvent.date = dateLabel.text ?? ""
    }
    
    @objc
    private func increaseHours() {
        labelValue += 1
        hoursLabel.text = "\(labelValue) ч. отдыха"
        
        if labelValue == ChillEvent.restHours {
            buttonIncrease.isEnabled = false
        } else {
            buttonIncrease.isEnabled = true
        }
        
        if labelValue == 2 {
            buttonDecrease.isEnabled = true
        }
    }
    
    @objc
    private func decreaseHours() {
        labelValue -= 1
        hoursLabel.text = "\(labelValue) ч. отдыха"
        
        if labelValue == 1 {
            buttonDecrease.isEnabled = false
        } else {
            buttonDecrease.isEnabled = true
        }
        
        if labelValue == ChillEvent.restHours - 1 {
            buttonIncrease.isEnabled = true
        }
    }
    
    @objc
    private func nextDayAction() {
        let daysToAdd = 1
        var dateComponent = DateComponents()
        
        dateComponent.day = daysToAdd
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        currentDate = futureDate!
        
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: currentDate)
        dateLabel.text = "\(calendarDate.day ?? 0) \(getMonthNameByNumber(calendarDate.month ?? 0)) \(calendarDate.year ?? 0)"
    }
    
    @objc
    private func previousDayAction() {
        let daysToAdd = -1
        var dateComponent = DateComponents()
        
        dateComponent.day = daysToAdd
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        currentDate = futureDate!
        
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: currentDate)
        dateLabel.text = "\(calendarDate.day ?? 0) \(getMonthNameByNumber(calendarDate.month ?? 0)) \(calendarDate.year ?? 0)"
    }
    
    private func setupDatePicker() {
        self.view.addSubview(dateLabel)
        let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: currentDate)
        dateLabel.text = "\(calendarDate.day ?? 0) \(getMonthNameByNumber(calendarDate.month ?? 0)) \(calendarDate.year ?? 0)"
        dateLabel.font = .systemFont(ofSize: 25, weight: .bold)
        dateLabel.textColor = .white
        dateLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        dateLabel.pinCenter(to: self.view.centerXAnchor)
        
        let nextDayButton = UIButton()
        let previousDayButton = UIButton()
        
        self.view.addSubview(nextDayButton)
        self.view.addSubview(previousDayButton)
        
        let image1 = UIImage(systemName: "arrowtriangle.forward.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let image2 = UIImage(systemName: "arrowtriangle.backward.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        nextDayButton.setImage(image1, for: .normal)
        previousDayButton.setImage(image2, for: .normal)
        
        previousDayButton.pinLeft(to: self.view.leadingAnchor, 70)
        previousDayButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        
        nextDayButton.pinRight(to: self.view.trailingAnchor, 70)
        nextDayButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        
        nextDayButton.addTarget(self, action: #selector(nextDayAction), for: .touchUpInside)
        previousDayButton.addTarget(self, action: #selector(previousDayAction), for: .touchUpInside)
    }
    
    // MARK: - Month getter
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
