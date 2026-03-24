//
//  BaseScreen.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 24.03.2026.
//
import XCTest

class BaseScreen {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
        print("App launched")
    }
    
    func hideKeyboard() {
        // Тапаем в точку: 50% по горизонтали, 10% по вертикали
        let outsideCoordinate = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1))
        outsideCoordinate.tap()
    }
}
