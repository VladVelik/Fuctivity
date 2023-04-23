//
//  RootViewController.swift
//  Fuctivity
//
//  Created by Kate on 21.04.2023.
//

import Foundation
import UIKit

class RootViewController: UIViewController{
    private var current: UIViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserDefaults.standard.bool(forKey: "loggedIn"){
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
}
