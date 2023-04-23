//
//  ChillHourViewController.swift
//  Fuctivity
//
//  Created by Федор Филиппов on 10.12.2022.
//

import UIKit

final class ChillHourViewController: UIViewController {
    // MARK: - Private Properties
    private let viewModel = ChillEventViewModel()

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
        
        self.view.addSubview(hoursLabel)
        hoursLabel.pinCenter(to: self.view.centerXAnchor)
        hoursLabel.pinBottom(to: self.view.centerYAnchor)
        hoursLabel.font = .systemFont(ofSize: 40, weight: .bold)
        hoursLabel.textColor = .black
        
        self.view.addSubview(buttonIncrease)
        self.view.addSubview(buttonDecrease)
        
        buttonIncrease.pinCenter(to: self.view.centerXAnchor)
        buttonIncrease.pinBottom(to: hoursLabel.topAnchor, 25)
        buttonIncrease.isEnabled = false
        buttonIncrease.addTarget(self, action: #selector(increaseHours), for: .touchUpInside)
        
        buttonDecrease.pinCenter(to: self.view.centerXAnchor)
        buttonDecrease.pinTop(to: hoursLabel.bottomAnchor, 25)
        buttonDecrease.addTarget(self, action: #selector(decreaseHours), for: .touchUpInside)
        
        let image1 = UIImage(systemName: "arrowtriangle.up.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let image2 = UIImage(systemName: "arrowtriangle.down.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        buttonIncrease.setImage(image1, for: .normal)
        buttonDecrease.setImage(image2, for: .normal)
        
        updateView()
    }
    
    // MARK: - Private Methods
    private func updateView() {
        hoursLabel.text = viewModel.hoursLabelText
        buttonIncrease.isEnabled = viewModel.labelValue < Settings.sharedSettings.getRestHours()
        buttonDecrease.isEnabled = viewModel.labelValue > 1
        dateLabel.text = viewModel.dateLabelText
    }
    
    private func setupLayer() {
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
    
    private func continueButtonSetup() {
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
    @objc private func continueAction() {
        self.navigationController?.pushViewController(self.categoryDescriptionViewController,
                                                      animated: true)
        ChillEvent.time = viewModel.labelValue
        ChillEvent.date = viewModel.dateLabelText
    }
    
    @objc private func increaseHours() {
        viewModel.increaseHours()
        updateView()
    }
    
    @objc private func decreaseHours() {
        viewModel.decreaseHours()
        updateView()
    }
    
    @objc private func nextDayAction() {
        viewModel.nextDay()
        updateView()
    }
    
    @objc private func previousDayAction() {
        viewModel.previousDay()
        updateView()
    }
    
    private func setupDatePicker() {
        self.view.addSubview(dateLabel)
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
        previousDayButton.addTarget(self, action: #selector(previousDayAction), for: .touchUpInside)
        
        nextDayButton.pinRight(to: self.view.trailingAnchor, 70)
        nextDayButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        nextDayButton.addTarget(self, action: #selector(nextDayAction), for: .touchUpInside)
    }
}
