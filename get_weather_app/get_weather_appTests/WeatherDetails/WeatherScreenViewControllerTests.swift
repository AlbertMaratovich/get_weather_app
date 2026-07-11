
//
//  WeatherScreenViewControllerTests.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 11.07.2026.
//

@testable import get_weather_app
import XCTest

final class WeatherScreenViewControllerTests: BaseUnitTest {
    var sut: WeatherViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(
            withIdentifier: "WeatherViewController"
        ) as? WeatherViewController
        
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    @MainActor
    func testTableViewRowsCountedSuccessfull() async throws {
        let mockNetwork = MockNetworkService()
        
        sut.forecast = try await mockNetwork.getWeather(city: "Almaty")
        
        let expectedRows = sut.forecast.count
        
        sut.tableView.layoutIfNeeded()
        
        let actualRows = sut.tableView(sut.tableView, numberOfRowsInSection: expectedRows)
        
        XCTAssertEqual(actualRows, expectedRows)
    }
    
    @MainActor
    func testTableViewWasLoadWithValidData() async throws {
        let mockNetwork = MockNetworkService()
        sut.forecast = try await mockNetwork.getWeather(city: "Almaty")
        
        sut.tableView.layoutIfNeeded()
        
        let targetRow = 0
        let indexPath = IndexPath(row: targetRow, section: 0)
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
        
        XCTAssertEqual(cell.textLabel?.text, "Morning: 22.6 °C")
    }
}
