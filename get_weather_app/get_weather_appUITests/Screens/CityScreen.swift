//
//  CityScreen.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 24.03.2026.
//
import XCTest

final class CityScreen: BaseScreen {
    var cityField: XCUIElement { app.textFields["city_field"] }
    var exists: Bool { cityField.exists }
    
    func isDisplayed() -> Bool {
        return cityField.waitForExistence(timeout: 5)
    }
}
