//
//  LogInViewController.swift
//  Fuctivity
//
//  Created by Sosin Vladislav on 10.12.2022.
//

import UIKit

final class LogInViewController: UIViewController {
    // MARK: - Public Properties
    var imageView = UIImageView()
    var logInButton = UIButton(type: .system)
    var textLabel = UILabel()
    
    let calendarViewController = CalendarViewController()
    
    // Data to save
    var nameTextField = UITextField()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    
    var userViewModel = UserViewModel()
    
    // MARK: - Override Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()
    }
    
    // MARK: - Private Method (place items on the storyboard)
    private func setElements() {
        setImage()
        
        setTextLabel(
            label: textLabel,
            x: 25,
            y: view.frame.size.height / 2.55,
            width: view.frame.size.width,
            height: view.frame.size.width / 11,
            text: "Вход в аккаунт",
            lines: 2,
            textType: "bold"
        )
        
        setLogInButton()
        setTextFields(nameTextField, text: "Пароль", tag: 0)
        setTextFields(emailTextField, text: "Email", tag: 1)
        setTextFields(passwordTextField, text: "Имя пользователя", tag: 2)
    }
    
    // MARK: - Private Methods (actions with buttons)
    private func setLogInButton() {
        logInButton.backgroundColor = UIColor(hex: 0x9D9DEE)
        logInButton.layer.cornerRadius = 12
        logInButton.setTitle("Войти", for: .normal)
        logInButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        logInButton.tintColor = .black
        logInButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        view.addSubview(logInButton)
        
        logInButton.setButtonConstraints(
            view: view,
            element: logInButton,
            equalToBottomAnchor: view.bottomAnchor,
            bAnchorSize: -view.frame.size.height / 9
        )
    }
    
    @objc
    private func loginAction() {
        userViewModel.login(username: nameTextField.text ?? "", password: passwordTextField.text ?? "", email: emailTextField.text ?? "")
        if  userViewModel.isLogin(){
            self.navigationController?.pushViewController(calendarViewController, animated: true)
        }
        else{
            let dialog = UIAlertController(title:"Пользоатель не найден", message:"Неверно введены данные для входа",
                                           preferredStyle: .alert)
            let okAction = UIAlertAction(title:"OK", style: .default, handler: {(alert:UIAlertAction!)-> Void in})
            dialog.addAction(okAction)
            self.present(dialog, animated:true, completion:nil)
            
            return
        }
        
    }
    
    // MARK: - Private Methods (place certain items on the storyboard)
    private func setTextFields(_ textField: UITextField, text: String, tag: Int) {
        textField.placeholder = text
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.borderStyle = UITextField.BorderStyle.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        
        if text == "Пароль" {
            textField.isSecureTextEntry = true
        } else {
            textField.clearButtonMode = UITextField.ViewMode.whileEditing
        }
            
        view.addSubview(textField)
        textField.setButtonConstraints(
            view: view,
            element: textField,
            equalToBottomAnchor: logInButton.bottomAnchor,
            bAnchorSize: -view.frame.size.height / CGFloat(4.5) - (view.frame.size.height / CGFloat(17)) * CGFloat(tag),
            leftAnchorSize: 40
        )
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
}


