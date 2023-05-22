
//
//  RootViewController.swift
//  Fuctivity
//
//  Created by Kate on 21.04.2023.
//

import Foundation
import UIKit

class RootViewController: UIViewController, UpdateRootController{
    private var current: UIViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserViewModel.shared.delegate = self

        if     !UserDefaults.standard.bool(forKey: "loggedIn"){
            current = MainViewController()
                    }
        else{
            current = CalendarViewController()
        }
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
        
    }
    
    func setCalendarController() {
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        let new = UINavigationController(rootViewController: CalendarViewController())
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        
        current = new
        
    }
}

protocol UpdateRootController : AnyObject{
    func setCalendarController();
}
