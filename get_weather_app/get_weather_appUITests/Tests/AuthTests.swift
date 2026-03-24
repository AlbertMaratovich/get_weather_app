//
//  get_weather_appUITests.swift
//  get_weather_appUITests
//
//  Created by Albert Gimalov on 07.02.2026.
//

import XCTest

final class AuthTestsUITests: BaseTest {

    func testAuthorizationWithValidData() throws {
        let loginScreen = LoginScreen(app: app)
        let cityScreen = CityScreen(app: app)

        loginScreen.typeTextLoginField("user")
        loginScreen.typeTextPasswordField("123456")
        loginScreen.loginButtonTap()
        
        XCTAssertTrue(cityScreen.isDisplayed(), "Экран выбора города не отобразился после логина")
    }
    
    func testAuthorizationWithInvalidPassword() throws {
        let loginScreen = LoginScreen(app: app)
        let cityScreen = CityScreen(app: app)
        
        loginScreen.typeTextLoginField("user")
        loginScreen.typeTextPasswordField("12345")
        loginScreen.loginButtonTap()
        
        XCTAssertTrue(loginScreen.errorLabelIsVisible(), "Лейбл с тестом ошибки не отобразился")
        XCTAssertFalse(cityScreen.exists, "Произошел вход в аккаунт с невалидными данными")
        XCTAssertTrue(loginScreen.loginButton.exists, "Ушли с экрана логина")
    }
    
    func testAuthorizationWithInvalidName() throws {
        let loginScreen = LoginScreen(app: app)
        let cityScreen = CityScreen(app: app)
        
        loginScreen.typeTextLoginField("userr")
        loginScreen.typeTextPasswordField("123456")
        loginScreen.loginButtonTap()
        
        XCTAssertTrue(loginScreen.errorLabelIsVisible(), "Лейбл с тестом ошибки не отобразился")
        XCTAssertFalse(cityScreen.exists, "Произошел вход в аккаунт с невалидными данными")
        XCTAssertTrue(loginScreen.loginButton.exists, "Ушли с экрана логина")
    }
    
    func testAuthorizationWithEmptyData() throws {
        let loginScreen = LoginScreen(app: app)
        let cityScreen = CityScreen(app: app)
        
        loginScreen.loginButtonTap()
        
        XCTAssertTrue(loginScreen.errorLabelIsVisible(), "Лейбл с тестом ошибки не отобразился")
        XCTAssertFalse(cityScreen.exists, "Произошел вход в аккаунт с невалидными данными")
        XCTAssertTrue(loginScreen.loginButton.exists, "Ушли с экрана логина")
    }
}
