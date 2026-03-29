//
//  CityScreen.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 24.03.2026.
//
import XCTest

final class CityScreen: BaseScreen {
    var cityField: XCUIElement { app.textFields["city_field"].firstMatch }
    var getWeatherButton: XCUIElement { app.buttons["get_weather_button"].firstMatch }
    var getWeatherByLocation: XCUIElement { app.buttons["wethaerByLocation"].firstMatch }
    var logoutButton: XCUIElement { app.buttons["log_out_button"].firstMatch }
    var errorLabel: XCUIElement { app.staticTexts["validationErrorLabel"].firstMatch }
    var exists: Bool { cityField.exists }
    
    func isDisplayed() -> Bool {
        return cityField.waitForExistence(timeout: 3)
    }
    
    func logoutButtonTap() {
        logoutButton.safeTap()
    }
    
    func getWeatherButtonTap() {
        getWeatherButton.safeTap()
    }
    
    func getWeatherByLocationButtonTap() {
        getWeatherByLocation.safeTap()
    }
    
    func typeTextCityField(_ text: String) {
        cityField.safeTap()
        cityField.typeText(text)
        hideKeyboard()
    }
}
