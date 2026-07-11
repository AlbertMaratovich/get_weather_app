//
//  CityViewModel.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 12.05.2026.
//

import XCTest
@testable import get_weather_app

final class CityViewModelTests: BaseUnitTest {
    let viewModel = CityViewModel()
    
    func testValidationCityWithValidData() {
        XCTAssertTrue(viewModel.validateCity(city: "Moscow"))
    }
    
    func testValidationCityWithInt() {
        XCTAssertFalse(viewModel.validateCity(city: "12345"))
    }
    
    func testValidationCityWithInvalidChars() {
        XCTAssertFalse(viewModel.validateCity(city: "Москва"))
    }
}
