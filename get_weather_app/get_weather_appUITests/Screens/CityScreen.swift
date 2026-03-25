//
//  CityScreen.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 24.03.2026.
//
import XCTest

final class CityScreen: BaseScreen {
    var cityField: XCUIElement { app.textFields["city_field"] }
    var getWeatherButton: XCUIElement { app.buttons["get_weather_button"] }
    var getWeatherByLocation: XCUIElement { app.buttons["wethaerByLocation"] }
    var logoutButton: XCUIElement { app.buttons["log_out_button"] }
    var errorLabel: XCUIElement { app.staticTexts["validationErrorLabel"] }
    var exists: Bool { cityField.exists }
    
    func isDisplayed() -> Bool {
        return cityField.waitForExistence(timeout: 3)
    }
    
    func logoutButtonTap() {
        logoutButton.tap()
    }
    
    func getWeatherButtonTap() {
        getWeatherButton.tap()
    }
    
    func typeTextCityField(_ text: String) {
        cityField.tap()
        cityField.typeText(text)
        hideKeyboard()
    }
}
