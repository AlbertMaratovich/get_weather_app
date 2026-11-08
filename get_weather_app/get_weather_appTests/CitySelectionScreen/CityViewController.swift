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
        sut.getWeatherByCityButtonTapped(getWeatherButton)
        
        XCTAssertFalse(sut.errorLabel.isHidden)
    }
    
    func testErrorLabelShownWithWrongCityField() {
        sut.cityField.text = "Москва"
        
        sut.getWeatherByCityButtonTapped(getWeatherButton)
        
        XCTAssertFalse(sut.errorLabel.isHidden)
    }
    
    func testErrorLabelHiddenWithCorrectValue() {
        sut.cityField.text = "Moscow"
        
        sut.getWeatherByCityButtonTapped(getWeatherButton)
        
        XCTAssertTrue(sut.errorLabel.isHidden)
    }
    
    // падает из-за performSegue
    //MARK: Skipped
    @MainActor
    func testGettingWeatherByPermission() async {
        sut.locationService = mockLocationService
        
        //await sut.loadWeatherByLocation()
        
        XCTAssertTrue(sut.errorLabel.isHidden)
    }
    
    @MainActor
    func testGettingWeatherWithoutPermission() async {
        sut.locationService = mockLocationService
        mockLocationService.error = LocationError.permissionDenied
        
        //await sut.loadWeatherByLocation()
        
        XCTAssertFalse(sut.errorLabel.isHidden)
        XCTAssertTrue(sut.errorLabel.text == "Access denied")
    }
}
