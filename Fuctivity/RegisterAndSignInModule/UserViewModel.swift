//
//  UserViewModel.swift
//  Fuctivity
//
//  Created by Kate on 21.04.2023.
//

import Foundation
import CryptoKit
class UserViewModel{
    static private(set) var currentUser: User = User()
    
    public func login(username: String, password: String, email: String){
        let hashpassword = passwordHash(email: email, password: password)
        if UserViewModel.currentUser.getUsername() == username && UserViewModel.currentUser.getHashPassword() == hashpassword && UserViewModel.currentUser.getEmail() == email{
            UserViewModel.currentUser.setLoggedIn(logIn: true)
            UserDefaults.standard.set(true, forKey: "loggedIn")
        }
        else{
            UserViewModel.currentUser.setLoggedIn(logIn: false)
            UserDefaults.standard.set(false, forKey: "loggedIn")
        }
    }
    public func isLogin() -> Bool{
        return UserViewModel.currentUser.getIsLogged()
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
        UserViewModel.currentUser.register(username: username, password: hashpassword, email: email)
    }
    
    func passwordHash(email: String, password: String) -> String {
        let salt = "x4vV8bGgqqmQwgCoyXFQj+(o.nUNQhVP7ND"
        return SHA256.hash(data: Data("\(password).\(email).\(salt)".utf8)).description
    }
}
