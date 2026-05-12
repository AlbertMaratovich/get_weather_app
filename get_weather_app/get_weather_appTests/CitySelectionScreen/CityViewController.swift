//
//  CityViewController.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 12.05.2026.
//

import XCTest
@testable import get_weather_app

final class CityViewControllerTests: BaseUnitTest {
    var sut: CityViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "CityViewController") as? CityViewController
        sut.loadViewIfNeeded()
    }
    
    // MARK: TODO
    func testCheckErrorLabelShown() {
        XCTAssertTrue(true)
    }
}
