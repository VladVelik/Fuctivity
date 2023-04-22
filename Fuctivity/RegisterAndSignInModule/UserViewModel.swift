//
//  UserViewModel.swift
//  Fuctivity
//
//  Created by Kate on 21.04.2023.
//

import Foundation
import CryptoKit
class UserViewModel{
    
    
    public func login(username: String, password: String, email: String){
        let hashpassword = passwordHash(email: email, password: password)
        if User.sharedUser.getUsername() == username && User.sharedUser.getHashPassword() == hashpassword && User.sharedUser.getEmail() == email{
            User.sharedUser.setLoggedIn(logIn: true)
            UserDefaults.standard.set(true, forKey: "loggedIn")
        }
        else{
            User.sharedUser.setLoggedIn(logIn: false)
            UserDefaults.standard.set(false, forKey: "loggedIn")
        }
    }
    public func isLogin() -> Bool{
        return User.sharedUser.getIsLogged()
    }
    
    public func register(username: String, password: String, email: String){
        if username.isEmpty || password.isEmpty || email.isEmpty{
            return
        }
        let hashpassword = passwordHash(email: email, password: password)
        UserDefaults.standard.set(true, forKey: "loggedIn")
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(hashpassword, forKey: "password")
        UserDefaults.standard.set(email, forKey: "email")
        User.sharedUser.register(username: username, password: hashpassword, email: email)
    }
    
    func passwordHash(email: String, password: String) -> String {
        let salt = "x4vV8bGgqqmQwgCoyXFQj+(o.nUNQhVP7ND"
        return SHA256.hash(data: Data("\(password).\(email).\(salt)".utf8)).description
    }
}
