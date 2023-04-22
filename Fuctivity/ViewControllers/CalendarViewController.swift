//
//  CalendarViewController.swift
//  Fuctivity
//
//  Created by Федор Филиппов on 08.12.2022.
//

import UIKit
import CalendarKit
import EventKit
import SwiftUI

final class CalendarViewController: DayViewController {
    // MARK: - Public Properties
    let chillHoursViewController = ChillHourViewController()
    let button = UIButton()
    let buttonToStats = UIButton()
    
    private let viewModel = ChillEventViewModel()
    
    // MARK: - Override Methods
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        return viewModel.getEventStorage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.UIColorFromRGB(rgbValue: 0xeb943d)
        title = "Fuctivity"
        
        setStyle()
        
        self.view.addSubview(button)
        button.setTitle("Нажмите, чтобы распределить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(setEvents), for: .touchUpInside)
        button.setHeight(to: 80)
        button.backgroundColor = UIColor.UIColorFromRGB(rgbValue: 0xeb943d)
        button.pinTop(to: self.dayView.dayHeaderView.bottomAnchor)
        button.pin(to: self.view, [.left: 0, .right: 0])
        getNotified()
        
        self.view.addSubview(buttonToStats)
        buttonToStats.setTitle("Посмотреть статистику", for: .normal)
        buttonToStats.setTitleColor(.white, for: .normal)
        buttonToStats.addTarget(self, action: #selector(openStatistics), for: .touchUpInside)
        buttonToStats.setHeight(to: 40)
        buttonToStats.backgroundColor = UIColor.blue
        buttonToStats.pinBottom(to: self.view.bottomAnchor)
        buttonToStats.pin(to: self.view, [.left: 0, .right: 0])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        if !Settings.sharedSettings.getDays().contains(String(Calendar.current.component(.weekday, from: self.dayView.state!.selectedDate))) {
            button.removeFromSuperview()
        }
        dayView.autoScrollToFirstEvent = true
        getNotified()
        reloadData()
    }
    
    // MARK: - Work with actions
    private func getNotified() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(storeChanged(_:)),
                                               name: .EKEventStoreChanged,
                                               object: nil)
    }
    
    @objc
    private func storeChanged(_ notification: Notification) {
        reloadData()
    }
    
    @objc
    public func setEvents() {
        self.navigationController?.pushViewController(self.chillHoursViewController, animated: true)
    }
    
    @objc
    private func openStatistics() {
        let hostingController = UIHostingController(rootView: StatisticView())
        self.navigationController?.pushViewController(hostingController, animated: true)        
    }
    
    //MARK: - Set style of storyboard
    func setStyle() {
        let color = UIColor.UIColorFromRGB(rgbValue: 0xaf95fc)
        var style = CalendarStyle()
        style.timeline.separatorColor = .white
        style.timeline.backgroundColor = .systemGray5
        style.header.backgroundColor = color
        style.header.daySelector.selectedBackgroundColor = .orange
        style.header.daySelector.todayActiveBackgroundColor = .orange
        
        style.header.separatorColor = color
        self.updateStyle(style)
    }
}
