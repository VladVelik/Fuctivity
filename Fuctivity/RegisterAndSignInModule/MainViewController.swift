//
//  ViewController.swift
//  Fuctivity
//
//  Created by Sosin Vladislav on 09.12.2022.
//

import UIKit

final class MainViewController: UIViewController {
    // MARK: - Public Properties
    var imageView = UIImageView()
    
    var welcomeLabel = UILabel()
    var restTextLabel = UILabel()
    var optionLabel = UILabel()
    var betweenLabel = UILabel()
    
    var logInButton = UIButton(type: .system)
    var registerButton = UIButton(type: .system)
    
    // MARK: - Override Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()
        addActions()
    }
    
    // MARK: - Private Method (place items on the storyboard)
    private func setElements() {
        setImage()
        
        setTextLabel(
            label: welcomeLabel,
            x: 25,
            y: view.frame.size.height / 2.25,
            width: view.frame.size.width,
            height: view.frame.size.width / 11,
            text: "Добро пожаловать в Fuctivity",
            lines: 2,
            textType: "bold"
        )
        
        setTextLabel(
            label: restTextLabel,
            x: 25,
            y: view.frame.size.height / 1.7,
            width: view.frame.size.width,
            height: view.frame.size.width / 22,
            text: "Надеюсь, вы готовы отдыхать!",
            textType: "bold"
        )
        
        setTextLabel(
            label: optionLabel,
            x: 25,
            y: view.frame.size.height / 1.6,
            width: view.frame.size.width,
            height: view.frame.size.width / 22,
            text: "Но перед этим, войдите в систему, чтобы иметь возможность сохранять прогресс.",
            lines: 2
        )
        
        setRegisterButton()
        setBetweenLabel()
        setLogInButton()
    }
    
    // MARK: - Private Methods (actions with buttons)
    private func addActions() {
        logInButton.addTarget(self, action: #selector(goToLogInController), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(goToRegisterController), for: .touchUpInside)
    }
    
    @objc
    private func goToLogInController() {
        let logInVC = LogInViewController()
        self.navigationController?.pushViewController(logInVC, animated: true)
    }
    
    @objc
    private func goToRegisterController() {
        let regVC = RegisterViewController()
        self.navigationController?.pushViewController(regVC, animated: true)
    }
    
    // MARK: - Private Methods (place certain items on the storyboard)
    private func setTextLabel(
        label: UILabel,
        x: CGFloat,
        y: CGFloat,
        width: CGFloat,
        height: CGFloat,
        text: String,
        lines: Int = 1,
        textType: String = "classic") {
        let k = lines > 1 ? lines + 1 : lines
        label.frame = CGRect(x: x, y: y, width: width, height: height * CGFloat(k))
        label.text = text
        label.numberOfLines = lines
            
        if textType == "classic" {
            label.font = UIFont.systemFont(ofSize: height)
        } else {
            label.font = UIFont.boldSystemFont(ofSize: height)
        }
        view.addSubview(label)
    }
    
    private func setImage() {
        view.backgroundColor = .white
        imageView = UIImageView(frame: self.view.bounds)
        imageView = UIImageView(frame: CGRect(
            x: -10,
            y: 0,
            width: view.frame.size.width + 10,
            height: view.frame.size.height / 2.2
        ))
        imageView.image = UIImage(named: "top_screen_honey")
        view.addSubview(imageView)
    }
    
    private func setRegisterButton() {
        registerButton.backgroundColor = UIColor(hex: 0xFAF2AD)
        registerButton.layer.cornerRadius = 12
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        registerButton.tintColor = .black
        view.addSubview(registerButton)
        
        registerButton.setButtonConstraints(
            view: view,
            element: registerButton,
            equalToBottomAnchor: view.bottomAnchor,
            bAnchorSize: -view.frame.size.height / 9
        )
    }
    
    private func setLogInButton() {
        logInButton.backgroundColor = UIColor(hex: 0x9D9DEE)
        logInButton.layer.cornerRadius = 12
        logInButton.setTitle("Войти", for: .normal)
        logInButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        logInButton.tintColor = .black
        view.addSubview(logInButton)
        
        logInButton.setButtonConstraints(
            view: view,
            element: logInButton,
            equalToBottomAnchor: betweenLabel.topAnchor,
            bAnchorSize: -10
        )
    }
    
    private func setBetweenLabel() {
        setTextLabel(label: betweenLabel, x: 0, y: 10, width: 100, height: 30, text: "----------------------- или -----------------------")
        betweenLabel.font = UIFont.systemFont(ofSize: 14)
        betweenLabel.textColor = .gray
        betweenLabel.translatesAutoresizingMaskIntoConstraints = false
        let bottomAnchor = betweenLabel.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -10)
        betweenLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NSLayoutConstraint.activate([bottomAnchor])
    }
}
