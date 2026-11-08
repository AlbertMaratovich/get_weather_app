//
//  CityViewController.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 12.05.2026.
//

import XCTest
import CoreLocation
@testable import get_weather_app

@MainActor
final class CityViewControllerTests: BaseUnitTest {
    let mockLocationService = MockLocationService()
    
    var sut: CityViewController!
    var getWeatherButton: UIButton! {
        sut.getWeatherButton
    }
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "CityViewController") as? CityViewController
        sut.loadViewIfNeeded()
    }

//    func testErrorLabelShownWithEmptyCityField() {
//        sut.getWeatherByCityButtonTapped(getWeatherButton)
//        
//        XCTAssertFalse(sut.errorLabel.isHidden)
//    }
    
//    func testErrorLabelShownWithWrongCityField() {
//        sut.cityField.text = "Москва"
//        
//        sut.getWeatherByCityButtonTapped(getWeatherButton)
//        
//        XCTAssertFalse(sut.errorLabel.isHidden)
//    }
    
    func testErrorLabelHiddenWithCorrectValue() {
        sut.cityField.text = "Moscow"
        
        sut.getWeatherByCityButtonTapped(getWeatherButton)
        
        XCTAssertTrue(sut.errorLabel.isHidden)
    }
}
