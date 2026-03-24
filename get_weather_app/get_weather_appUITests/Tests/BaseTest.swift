//
//  BaseTest.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 24.03.2026.
//
import XCTest

@MainActor
class BaseTest: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Останавливает прохождения теста если ранее была получена ошибка
        continueAfterFailure = false
        
        // инициализация и запуск приложения
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
        try super.tearDownWithError()
    }
}
