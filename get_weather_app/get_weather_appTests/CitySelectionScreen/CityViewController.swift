//
//  CityViewController.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 12.05.2026.
//

import XCTest
import CoreLocation
@testable import get_weather_app

final class CityViewControllerTests: BaseUnitTest {
    var sut: CityViewController!
    lazy var getWeatherButton = sut.getWeatherButton!
    let mockLocationService = MockLocationService()
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "CityViewController") as? CityViewController
        sut.loadViewIfNeeded()
    }

    func testErrorLabelShownWithEmptyCityField() {
        sut.getWeatherButtonTapped(getWeatherButton)
        
        XCTAssertFalse(sut.validationErrorLabel.isHidden)
    }
    
    func testErrorLabelShownWithWrongCityField() {
        sut.cityField.text = "Москва"
        
        sut.getWeatherButtonTapped(getWeatherButton)
        
        XCTAssertFalse(sut.validationErrorLabel.isHidden)
    }
    
    func testErrorLabelHiddenWithCorrectValue() {
        sut.cityField.text = "Moscow"
        
        sut.getWeatherButtonTapped(getWeatherButton)
        
        XCTAssertTrue(sut.validationErrorLabel.isHidden)
    }
    
    // падает из-за performSegue
    @MainActor
    func testGettingWeatherByPermission() async {
        sut.locationService = mockLocationService
        
        await sut.loadWeatherByLocation()
        
        XCTAssertTrue(sut.validationErrorLabel.isHidden)
    }
    
    @MainActor
    func testGettingWeatherWithoutPermission() async {
        sut.locationService = mockLocationService
        mockLocationService.error = LocationError.permissionDenied
        
        await sut.loadWeatherByLocation()
        
        XCTAssertFalse(sut.validationErrorLabel.isHidden)
        XCTAssertTrue(sut.validationErrorLabel.text == "Access denied")
    }
}
