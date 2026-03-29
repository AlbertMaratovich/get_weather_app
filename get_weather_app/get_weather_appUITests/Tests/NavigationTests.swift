//
//  NavigationTests.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 24.03.2026.
//
import XCTest

final class NavigationTests: BaseTest {
    
    func testReturnToFirstScreen() throws {
        let cityScreen = CityScreen(app: app)
        let loginScreen = LoginScreen(app: app)
        let weatherScreen = WeatherScreen(app: app)
        
        loginScreen.typeTextLoginField("user")
        loginScreen.typeTextPasswordField("123456")
        loginScreen.loginButtonTap()
        cityScreen.typeTextCityField("Moscow")
        cityScreen.getWeatherButtonTap()
        
        XCTAssertTrue(weatherScreen.isDisplayed())
        
        weatherScreen.navBarTap()
        weatherScreen.navBarTap()
        
        XCTAssertTrue(loginScreen.isDisplayed())
    }
}
