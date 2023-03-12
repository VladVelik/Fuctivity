//
//  CategoryDescriptionViewController.swift
//  Fuctivity
//
//  Created by Федор Филиппов on 10.12.2022.
//

import Foundation
import UIKit

final class CategoryDescriptionViewController: UIViewController {
    // MARK: - Public Properties
    let continueButton = UIButton()
    let textView = UITextView()
    let descriptionLabel = UILabel()
    let hourLabel = UIButton()
    let categoryButton = UIButton()
    let createCategoryButton = UIButton()
    
    let reminderViewController = ReminderViewController()
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupContinueButton()
        setupHourInfoLabel()
        setupCategoryButton()
        setupTextView()
        //createNewCategoryButtonSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hourLabel.setTitle("\(ChillEvent.time) ч. отдыха", for: .normal)
        textView.text = nil
        navigationController?.navigationBar.barStyle = UIBarStyle.default
    }
    
    // MARK: - Work with actions
    private func setupContinueButton() {
        self.view.addSubview(continueButton)
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.setHeight(to: 40)
        continueButton.setTitleColor(.white, for: .normal)
        continueButton.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
        continueButton.backgroundColor = UIColor.UIColorFromRGB(rgbValue: 0xaf95fc)
        continueButton.layer.cornerRadius = 12
        continueButton.pinTop(to: self.view.centerYAnchor)
        continueButton.pin(to: self.view, [.left: 90, .right: 90])
    }
    
    @objc
    private func continueAction() {
        self.navigationController?.pushViewController(self.reminderViewController, animated: true)
        
        ChillEvent.eventDescription = textView.text
        ChillEvent.categoryOfEvent = (categoryButton.titleLabel?.text)!
    }
    
    //MARK: - Private Methods
    private func setupHourInfoLabel() {
        self.view.addSubview(hourLabel)
        hourLabel.setTitle("\(ChillEvent.time) ч. отдыха", for: .normal)
        hourLabel.setHeight(to: 40)
        hourLabel.setTitleColor(.white, for: .normal)
        hourLabel.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        hourLabel.backgroundColor = UIColor.UIColorFromRGB(rgbValue: 0xaf95fc)
        hourLabel.layer.cornerRadius = 12
        hourLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        hourLabel.pinLeft(to: self.view.leadingAnchor, 20)
        hourLabel.pin(to: self.view, [.left: 20, .right: 160])
    }
    
    private func setupCategoryButton() {
        self.view.addSubview(categoryButton)
        let categoryHandler = {
            (action: UIAction) in print()
        }
        
        categoryButton.menu = UIMenu(children: [
            UIAction(title: "Категория:\tГейминг", handler: categoryHandler),
            UIAction(title: "Категория:\tСон", handler: categoryHandler),
            UIAction(title: "Категория:\tПрогулка", handler: categoryHandler)
        ])
        
        categoryButton.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            categoryButton.changesSelectionAsPrimaryAction = true
        } else {
        }
        
        categoryButton.setTitleColor(.black, for: .normal)
        categoryButton.layer.cornerRadius = 7
        categoryButton.setHeight(to: 60)
        categoryButton.setTitle("Категория не выбрана", for: .normal)
        categoryButton.backgroundColor = UIColor.UIColorFromRGB(rgbValue: 0xf1ebfa)
        categoryButton.pinBottom(to: continueButton.topAnchor, 60)
        categoryButton.pin(to: self.view, [.left: 20, .right: 20])
    }
    
    private func setupTextView() {
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.setHeight(to: 100)
        
        descriptionLabel.text = "Напишите примерный план, чем хотите заняться"
        
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, textView])
        self.view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        
        self.textView.layer.borderColor = UIColor.gray.cgColor
        self.textView.layer.borderWidth = 2.0;
        self.textView.layer.cornerRadius = 10;

        descriptionLabel.numberOfLines = 0
        
        stackView.pinTop(to: hourLabel.bottomAnchor, 20)
        stackView.pin(to: self.view, [.left: 20, .right: 20])
        
        stackView.subviews[0].pin(to: stackView, [.left: 10, .right: 30])
        stackView.subviews[0].pinTop(to: stackView.topAnchor, 15)
        stackView.subviews[1].pinBottom(to: stackView.bottomAnchor, 30)
        stackView.subviews[1].pin(to: stackView, [.left: 10, .right: 30])
        
        stackView.backgroundColor = UIColor.UIColorFromRGB(rgbValue: 0xf1ebfa)
        stackView.layer.cornerRadius = 7
    }
    
    private func createNewCategoryButtonSetup() {
        self.view.addSubview(createCategoryButton)
        createCategoryButton.backgroundColor = .white
        createCategoryButton.setTitle("Создать новую категорию...", for: .normal)
        createCategoryButton.setTitleColor(.systemGray2, for: .normal)
        
        createCategoryButton.pin(to: self.view, [.left: 20, .right: 20])
        createCategoryButton.pinTop(to: categoryButton.bottomAnchor)
        createCategoryButton.pinBottom(to: continueButton.topAnchor, 10)
        //createCategoryButton.addTarget(self, action: #selector(createNewCategory), for: .touchUpInside)
    }
}
