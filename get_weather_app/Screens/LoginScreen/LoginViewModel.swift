//
//  LoginViewModel.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 08.02.2026.
//

struct LoginViewModel {
    private let login = "user"
    private let pass = "123456"
    
    func canLogin(user: String, pass: String) -> Bool {
        if user == self.login && pass == self.pass {
            return true
        } else {
            return false
        }
    }
}
