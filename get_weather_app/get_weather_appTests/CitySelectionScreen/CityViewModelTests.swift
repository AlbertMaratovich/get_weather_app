//
//  CityViewModel.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 12.05.2026.
//

import XCTest
@testable import get_weather_app

final class CityViewModelTests: BaseUnitTest {
    private let viewModel = CityViewModel()
    
    func testValidationCityWithValidData() {
        XCTAssertTrue(viewModel.validateCity(city: "Moscow"))
    }
    
    func testValidationCityWithInt() {
        XCTAssertFalse(viewModel.validateCity(city: "12345"))
    }
    
    func testValidationCityWithInvalidChars() {
        XCTAssertFalse(viewModel.validateCity(city: "Москва"))
    }
    
    func testValidationCityWithEmptyField() {
        XCTAssertFalse(viewModel.validateCity(city: ""))
    }
    
    func testGetWeatherByCityWithValidData() async throws {
        viewModel.service = MockNetworkService()
        
        let forecast = try await viewModel.getWeather(city: "Moscow")
        
        XCTAssertTrue(forecast.count == 4, "Количество дней в прогнозе не равно 4")
        XCTAssertEqual(forecast.first?.temp, "22.6 °C", "Температура утром не совпадает с данными мока")
    }
    
    func testGetWeatherByLocationWithValidData() async throws {
        viewModel.service = MockNetworkService()
        
        let forecast = try await viewModel.getWeatherByLocation(lat: 55.7558, lon: 37.6173)
        
        XCTAssertTrue(forecast.count == 4, "Количество дней в прогнозе не равно 4")
        XCTAssertEqual(forecast.first?.temp, "22.6 °C", "Температура утром не совпадает с данными мока")
    }
}
