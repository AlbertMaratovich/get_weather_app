//
//  LoginScreen.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 24.03.2026.
//
import XCTest

final class LoginScreen: BaseScreen {
    var loginField: XCUIElement { app.textFields["name_field"] }
    var passwordField: XCUIElement { app.textFields["password_field"] }
    var loginButton: XCUIElement { app.buttons["login_button"] }
    var loginErrorLabel: XCUIElement { app.staticTexts["loginError"] }
    
    func typeTextLoginField(_ text: String) {
        loginField.tap()
        loginField.typeText(text)
        hideKeyboard()
    }
    
    func typeTextPasswordField(_ text: String) {
        passwordField.tap()
        passwordField.typeText(text)
        hideKeyboard()
    }
    
    func loginButtonTap() {
        loginButton.tap()
    }
    
    func errorLabelIsVisible() -> Bool {
        return loginErrorLabel.waitForExistence(timeout: 3)
    }
}
