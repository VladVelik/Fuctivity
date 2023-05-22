//
//  ChooseRestViewController.swift
//  Fuctivity
//
//  Created by Sosin Vladislav on 12.12.2022.
//

import UIKit

final class ChooseRestViewController: UIViewController {
    // MARK: - Public Properties
    var boldTextLabel = UILabel()
    var secondTextLabel = UILabel()
    var textUnderField = UILabel()
    
    var textField = UITextField()
    
    let calendarViewController = CalendarViewController()
    
    var nextStepButton = UIButton(type: .system)
    var plusButton = UIButton(type: .system)
    var minusButton = UIButton(type: .system)
    
    var settingsViewModel = SettingsViewModel()
    
    // MARK: - Override Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()
        addActions()
    }
    
    // MARK: - Private Method (place items on the storyboard)
    private func setElements() {
        view.backgroundColor = .white
        setBoldText()
        setSecondText()
        setNextButton()
        setTextField()
        setPlusButton()
        setMinusButton()
        setTextUnderField()
    }
    
    // MARK: - Private Methods (actions with buttons)
    private func addActions() {
        minusButton.addTarget(self, action: #selector(minusTextField), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusTextField), for: .touchUpInside)
    }
    
    @objc
    private func plusTextField() {
        let special = Int(textField.text ?? "") ?? 6
        textField.text = settingsViewModel.plusRestHours(restHours: special)
    }
    
    @objc
    private func minusTextField() {
        let special = Int(textField.text ?? "") ?? 6
        textField.text = settingsViewModel.minusRestHours(restHours: special)
    }
    
    @objc
    private func goToCalendar() {
        settingsViewModel.setRestHours(restHours: Int(textField.text ?? "") ?? 5)
        
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        
//        ChillEvent.eventStorage = []
        
        
        self.navigationController?.pushViewController(calendarViewController, animated: true)
    }
    
    // MARK: - Private Methods (place certain items on the storyboard)
    private func setBoldText() {
        boldTextLabel.text = """
        Сколько часов ежедневно вы готовы тратить на отдых?
        """
        boldTextLabel.font = UIFont.boldSystemFont(ofSize: view.frame.size.width / 12.3)
        boldTextLabel.numberOfLines = 5
        view.addSubview(boldTextLabel)
    
        boldTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = boldTextLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.size.height / 10)
        let leftAnchor = boldTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        let rightAnchor = boldTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        
        NSLayoutConstraint.activate([topAnchor, leftAnchor, rightAnchor])
    }
    
    private func setSecondText() {
        secondTextLabel.text = """
        В нашем приложении мы бережно храним ваши часы отдыха и напоминаем вам из потратить. Задайте ежедневный объём отдыха для рабочих дней! Ночной сон не входит в расчёт.
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
    
    private func setNextButton() {
        nextStepButton.backgroundColor = UIColor(hex: 0x9D9DEE)
        nextStepButton.layer.cornerRadius = 15
        nextStepButton.setTitle("Готово!", for: .normal)
        nextStepButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        nextStepButton.tintColor = .black
        nextStepButton.addTarget(self, action: #selector(goToCalendar), for: .touchUpInside)
        view.addSubview(nextStepButton)
        
        nextStepButton.setButtonConstraints(
            view: view,
            element: nextStepButton,
            equalToBottomAnchor: view.bottomAnchor,
            bAnchorSize: -view.frame.size.height / 9
        )
    }
    
    private func setTextField() {
        textField.placeholder = "8"
        textField.text = "8"
        textField.font = UIFont.systemFont(ofSize: 100)
        textField.borderStyle = UITextField.BorderStyle.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.numberPad
        textField.returnKeyType = UIReturnKeyType.done
        textField.textAlignment = .center
        textField.backgroundColor = UIColor(hex: 0xFFBA52)
        textField.layer.cornerRadius = 15
        
        addDoneButtonOnNumpad(textField: textField)
        view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomAnchor = textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.size.height / 2.5)
        let widthAnchor = NSLayoutConstraint(
            item: textField,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 110
        )
        
        NSLayoutConstraint.activate([bottomAnchor, widthAnchor, textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])
    }

    func addDoneButtonOnNumpad(textField: UITextField) {
        let keypadToolbar: UIToolbar = UIToolbar()
        
        keypadToolbar.items = [
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        ]
        
        keypadToolbar.sizeToFit()
        textField.inputAccessoryView = keypadToolbar
    }
    
    private func setPlusButton() {
        plusButton.backgroundColor = UIColor(hex: 0xFAF2AD)
        plusButton.layer.cornerRadius = 20
        plusButton.setTitle("+", for: .normal)
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        plusButton.tintColor = UIColor(hex: 0xFFBA52)
        plusButton.titleLabel?.textAlignment = .center
        view.addSubview(plusButton)
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false

        let leftAnchor = plusButton.leftAnchor.constraint(equalTo: textField.rightAnchor, constant: 20)
        let heightAnchor = NSLayoutConstraint(
            item: plusButton,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40
        )
        
        let widthAnchor = NSLayoutConstraint(
            item: plusButton,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40
        )
        
        NSLayoutConstraint.activate([leftAnchor, heightAnchor, widthAnchor, plusButton.centerYAnchor.constraint(equalTo: self.textField.centerYAnchor)])
    }
    
    private func setMinusButton() {
        minusButton.backgroundColor = UIColor(hex: 0xFAF2AD)
        minusButton.layer.cornerRadius = 20
        minusButton.setTitle("-", for: .normal)
        minusButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        minusButton.tintColor = UIColor(hex: 0xFFBA52)
        minusButton.titleLabel?.textAlignment = .center
        view.addSubview(minusButton)
        
        minusButton.translatesAutoresizingMaskIntoConstraints = false

        let rightAnchor = minusButton.rightAnchor.constraint(equalTo: textField.leftAnchor, constant: -20)
        let heightAnchor = NSLayoutConstraint(
            item: minusButton,
            attribute: NSLayoutConstraint.Attribute.height,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40
        )
        
        let widthAnchor = NSLayoutConstraint(
            item: minusButton,
            attribute: NSLayoutConstraint.Attribute.width,
            relatedBy: NSLayoutConstraint.Relation.equal,
            toItem: nil,
            attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40
        )
        
        NSLayoutConstraint.activate([rightAnchor, heightAnchor, widthAnchor, minusButton.centerYAnchor.constraint(equalTo: self.textField.centerYAnchor)])
    }
    
    private func setTextUnderField() {
        textUnderField.text = """
        Ввести количество вручную
        """
        textUnderField.font = UIFont.systemFont(ofSize: view.frame.size.width / 25)
        textUnderField.numberOfLines = 5
        textUnderField.textColor = .gray
        view.addSubview(textUnderField)
        
        textUnderField.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = textUnderField.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: view.frame.size.height / 30)
        
        NSLayoutConstraint.activate([topAnchor, textUnderField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])
    }
}
