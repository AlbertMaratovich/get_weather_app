//
//  GettingWeatherTests.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 24.03.2026.
//

import XCTest

final class GettingWeatherTests: BaseTest {
    
    func testGetWeatherByCityName() throws {
        let cityScreen = CityScreen(app: app)
        let loginScreen = LoginScreen(app: app)
        let weatherScreen = WeatherScreen(app: app)
        
        loginScreen.typeTextLoginField("user")
        loginScreen.typeTextPasswordField("123456")
        loginScreen.loginButtonTap()
        cityScreen.typeTextCityField("Moscow")
        cityScreen.getWeatherButtonTap()
        XCTAssertTrue(weatherScreen.validateTable(), "Погода в ячейке не отобразилась")
    }
    
    func testGetWeatherByLocation() throws {
        
    }
    
    func testValidationCityField() throws {
        
    }
    
    func testGetWeatherRepeat() throws {
        
    }
    
    func testGetWeatherAfterAproveOneTimePermisson() throws {
        
    }
    
    func testGetWeatherAfterDenyPermisson() throws {
        
    }
}
