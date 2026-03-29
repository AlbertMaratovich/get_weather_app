//
//  LoginScreen.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 24.03.2026.
//
import XCTest

final class LoginScreen: BaseScreen {
    var loginField: XCUIElement { app.textFields["name_field"].firstMatch }
    var passwordField: XCUIElement { app.textFields["password_field"].firstMatch }
    var loginButton: XCUIElement { app.buttons["login_button"].firstMatch }
    var loginErrorLabel: XCUIElement { app.staticTexts["loginError"].firstMatch }
    
    func typeTextLoginField(_ text: String) {
        loginField.safeTap()
        loginField.typeText(text)
        hideKeyboard()
    }
    
    func typeTextPasswordField(_ text: String) {
        passwordField.safeTap()
        passwordField.typeText(text)
        hideKeyboard()
    }
    
    func loginButtonTap() {
        loginButton.safeTap()
    }
    
    func errorLabelIsVisible() -> Bool {
        return loginErrorLabel.waitForExistence(timeout: 3)
    }
    
    func isDisplayed() -> Bool {
        return loginButton.waitForExistence(timeout: 3)
    }
}
