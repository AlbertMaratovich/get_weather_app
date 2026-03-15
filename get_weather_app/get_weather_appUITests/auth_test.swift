//
//  get_weather_appUITests.swift
//  get_weather_appUITests
//
//  Created by Albert Gimalov on 07.02.2026.
//

import XCTest

final class auth_testUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testAuthorizationWithValidData() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        print("app launched")

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let login_field = app.textFields["name_field"]
        let password_field = app.textFields["password_field"]
        let city_field = app.textFields["city_field"]
        let login_button = app.buttons["login_button"]
        
        
        // ожидание появления текстового поля
        //XCTAssertTrue(login_field.waitForExistence(timeout: 5))
        
        login_field.tap()
        login_field.typeText("user")
        
        password_field.tap()
        password_field.typeText("123456")
        
        // тап на кнопку ретерн клавиатуры (для скрытия клавиатуры)
        //app.keyboards.buttons["Return"].tap()
        
        // тап по свободной области для скрытия клавиатуры
        app.tap()
        
        // тап на кнопку логина
        login_button.tap()
        
        XCTAssertTrue(city_field.waitForExistence(timeout: 5))
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
