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
        
        XCTAssertTrue(weatherScreen.isDisplayed(), "Экран погоды не отобразился")
        XCTAssertTrue(weatherScreen.validateTable(), "Погода в ячейках не отобразилась")
    }
    
    func testGetWeatherByLocation() throws {
        let cityScreen = CityScreen(app: app)
        let loginScreen = LoginScreen(app: app)
        let weatherScreen = WeatherScreen(app: app)
        
        loginScreen.typeTextLoginField("user")
        loginScreen.typeTextPasswordField("123456")
        loginScreen.loginButtonTap()
        cityScreen.getWeatherByLocationButtonTap()
        cityScreen.allowOnceLocationPermission()
        
        XCTAssertTrue(weatherScreen.isDisplayed(), "Экран погоды не отобразился")
        XCTAssertTrue(weatherScreen.validateTable(), "Погода в ячейках не отобразилась")
    }
    
    func testValidationCityField() throws {
        let cityScreen = CityScreen(app: app)
        let loginScreen = LoginScreen(app: app)
        let weatherScreen = WeatherScreen(app: app)
        
        loginScreen.typeTextLoginField("user")
        loginScreen.typeTextPasswordField("123456")
        loginScreen.loginButtonTap()
        cityScreen.typeTextCityField("Москва")
        cityScreen.getWeatherButtonTap()
        
        XCTAssertTrue(cityScreen.errorLabel.waitForExistence(timeout: 3), "Лейбл ошибки не отобразился при невалидном значении")
        XCTAssertFalse(weatherScreen.exists, "Поле приняло не валидное значение")
    }
    
    func testGetWeatherRepeat() throws {
        let cityScreen = CityScreen(app: app)
        let loginScreen = LoginScreen(app: app)
        let weatherScreen = WeatherScreen(app: app)
        
        loginScreen.typeTextLoginField("user")
        loginScreen.typeTextPasswordField("123456")
        loginScreen.loginButtonTap()
        cityScreen.typeTextCityField("Astana")
        cityScreen.getWeatherButtonTap()
        
        XCTAssertTrue(weatherScreen.isDisplayed(), "Экран погоды не отобразился")
        let firstCityWeather = weatherScreen.firstCell
        
        weatherScreen.backButtonTap()
        cityScreen.cityField.clearText()
        cityScreen.typeTextCityField("Palermo")
        cityScreen.getWeatherButtonTap()
        
        XCTAssertTrue(weatherScreen.isDisplayed(), "Экран погоды не отобразился")
        let secondCityWeather = weatherScreen.firstCell
        
        XCTAssertTrue(firstCityWeather != secondCityWeather, "Погода не перезагрузилась")
    }
}
