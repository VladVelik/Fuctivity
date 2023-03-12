//
//  ViewController.swift
//  Fuctivity
//
//  Created by Федор Филиппов on 08.12.2022.
//

import UIKit
import CalendarKit

class ViewController: UIViewController {
    
    let calendarViewController = CalendarViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
                
        let button = UIButton()
        self.view.addSubview(button)
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 12
        button.pinTop(to: self.view.centerYAnchor)
        button.pin(to: self.view, [.left: 60, .right: 60])
        button.addTarget(self, action: #selector(calendarOpen), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(true, animated: false)
    }

    @objc
    private func calendarOpen() {
//        calendarViewController.modalPresentationStyle = .fullScreen
//        calendarViewController.modalTransitionStyle = .crossDissolve
//        present(self.calendarViewController, animated: true)
        self.navigationController?.pushViewController(self.calendarViewController, animated: true)
    }
}

