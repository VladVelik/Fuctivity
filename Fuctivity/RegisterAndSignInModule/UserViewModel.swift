//
//  UserViewModel.swift
//  Fuctivity
//
//  Created by Kate on 21.04.2023.
//

import Foundation

class UserViewModel{
    
    
    public func login(username: String, password: String, email: String){
        User.sharedUser.checkLogin(username: username, password: password, email: email)
    }
    public func isLogin() -> Bool{
        return User.sharedUser.isLogin()
    }
    
    public func register(username: String, password: String, email: String){
        if username.isEmpty || password.isEmpty || email.isEmpty{
            return
        }
        User.sharedUser.register(username: username, password: password, email: email)
    }
}
