//
//  DayChooseViewController.swift
//  Fuctivity
//
//  Created by Sosin Vladislav on 12.12.2022.
//

import UIKit

final class DayChooseViewController: UIViewController {
    // MARK: - Public Properties
    var boldTextLabel = UILabel()
    var secondTextLabel = UILabel()
    
    var nextStepButton = UIButton(type: .system)
    
    var buttonsColumnSize: Int = 0
    var betweenButtonsDistance: Int = 0
    var buttons = [UIButton]()
    var currentIterator: Int = 0
    
    var weekDays: [String] = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    
    var settingViewModel = SettingsViewModel()
    
    // MARK: - Override Method
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserViewModel.shared.currentUser.getEmail())
        buttonsColumnSize = Int(view.frame.size.width / 5.5)
        betweenButtonsDistance = Int(view.frame.size.width / 17.2)
        navigationItem.setHidesBackButton(true, animated: true)
        setElements()
        addActions()
    }
    
    // MARK: - Private Method (place items on the storyboard)
    private func setElements() {
        view.backgroundColor = .white
        createButtons(0, 4, Int(view.frame.size.height / 1.9))
        createButtons(4, 7, Int(view.frame.size.height / 1.9) + buttonsColumnSize + betweenButtonsDistance)
        setBoldText()
        setSecondText()
        setNextButton()
    }
    
    // MARK: - Private Methods (actions with buttons)
    private func addActions() {
        nextStepButton.addTarget(self, action: #selector(goToNextController), for: .touchUpInside)
    }
    
    @objc
    private func goToNextController() {
        var currentDays = ""
        for button in buttons {
            if button.backgroundColor == UIColor(hex: 0xFFBA52) {
                currentDays += weekDayNumber(day: (button.titleLabel?.text)!)
            }
        }
        settingViewModel.setDays(days: currentDays)
        let chooseHoursVC = ChooseHoursViewController()
        self.navigationController?.pushViewController(chooseHoursVC, animated: true)
    }
    
    @objc
    private func becomeOrange(sender: UIButton) {
        sender.backgroundColor =
        sender.backgroundColor == .white ? UIColor(hex: 0xFFBA52) : .white
    }
    
    // MARK: - Private Methods (place certain items on the storyboard)
    private func setBoldText() {
        boldTextLabel.text = """
        Отлично!
        Следующий шаг — распределить ваши дни на рабочие и выходные
        """
        boldTextLabel.font = UIFont.boldSystemFont(ofSize: view.frame.size.width / 12.3)
        boldTextLabel.numberOfLines = 5
        view.addSubview(boldTextLabel)
        
        boldTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = boldTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.size.height / 14)
        let leftAnchor = boldTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        let rightAnchor = boldTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        
        NSLayoutConstraint.activate([topAnchor, leftAnchor, rightAnchor])
    }
    
    private func setSecondText() {
        secondTextLabel.text = """
        Отметьте пожалуйста, в какие дни вы работаете. Если у вас нестабильный график — просто отметьте все дни!
        """
        secondTextLabel.font = UIFont.systemFont(ofSize: view.frame.size.width / 21.5)
        secondTextLabel.numberOfLines = 5
        view.addSubview(secondTextLabel)
        
        secondTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = secondTextLabel.topAnchor.constraint(equalTo: boldTextLabel.bottomAnchor, constant: view.frame.size.height / 30)
        let leftAnchor = secondTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        let rightAnchor = secondTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        
        NSLayoutConstraint.activate([topAnchor, leftAnchor, rightAnchor])
    }
    
    private func createButtons(_ first: Int, _ second: Int, _ yy: Int) {
        var y = 20
        
        for i in first..<second {
            currentIterator = i
            let button = UIButton()
            button.frame = CGRect(x: y, y: yy, width: buttonsColumnSize, height: buttonsColumnSize)
            button.titleLabel?.textAlignment = .center
            button.layer.cornerRadius = 15
            button.backgroundColor = .white
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
            button.setTitle("\(weekDays[i])", for: .normal)
            button.addTarget(self, action: #selector(becomeOrange(sender:)), for: .touchUpInside)
            button.setTitleColor(.black, for: .normal)
            view.addSubview(button)
            buttons.append(button)
            
            y += buttonsColumnSize + betweenButtonsDistance
        }
    }
    
    private func weekDayNumber(day: String) -> String {
        switch day {
        case "Вс":
            return "1"
        case "Пн":
            return "2"
        case "Вт":
            return "3"
        case "Ср":
            return "4"
        case "Чт":
            return "5"
        case "Пт":
            return "6"
        case "Сб":
            return "7"
        default:
            return "0"
        }
    }
    
    private func setNextButton() {
        nextStepButton.backgroundColor = UIColor(hex: 0x9D9DEE)
        nextStepButton.layer.cornerRadius = 15
        nextStepButton.setTitle("Продолжить", for: .normal)
        nextStepButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        nextStepButton.tintColor = .black
        view.addSubview(nextStepButton)
        
        nextStepButton.setButtonConstraints(
            view: view,
            element: nextStepButton,
            equalToBottomAnchor: view.bottomAnchor,
            bAnchorSize: -view.frame.size.height / 9
        )
    }
}
