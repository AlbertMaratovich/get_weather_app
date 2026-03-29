//
//  BaseScreen.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 24.03.2026.
//
import XCTest

class BaseScreen {
    let app: XCUIApplication
    lazy var springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    init(app: XCUIApplication) {
        self.app = app
        print("App launched")
    }
    
    func hideKeyboard() {
        // Тапаем в точку: 50% по горизонтали, 10% по вертикали
        let outsideCoordinate = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1))
        outsideCoordinate.tap()
    }
    
    func allowOnceLocationPermission() {
        let alert = springboard.alerts.firstMatch
        let aproveText: [String] = ["Однократно", "Allow Once", "Разрешить один раз"]
            
        if alert.waitForExistence(timeout: 3) {
            let button = alert.buttons.allElementsBoundByIndex.first { button in
                aproveText.contains(button.label)
            }
            if let button = button, button.exists {
                button.tap()
            } else {
                XCTFail("Кнопка дачи пермишена не найдена в запросе доступа к геолокации")
            }
        } else {
            XCTFail("Запрос геолокации не появился")
        }
    }
}
