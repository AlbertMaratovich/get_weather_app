//
//  WeatherScreen.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 24.03.2026.
//

import XCTest

final class WeatherScreen: BaseScreen {
    var weatherTableView: XCUIElement { app.tables["weather_table_view"].firstMatch }
    var backButton: XCUIElement { app.buttons["back_button"].firstMatch }
    let expectedLabels = ["Morning:", "Afternoon:", "Evening:", "Night:"]
    
    func backButtonTap() {
        backButton.tap()
    }
    
    func validateTable() -> Bool {
        guard weatherTableView.waitForExistence(timeout: 5) else {
            print("Ошибка: Таблица погоды не найдена")
            return false
        }
        
        for (index, text) in expectedLabels.enumerated() {
            let cell = weatherTableView.cells.element(boundBy: index)
            if !cell.exists || !cell.label.contains(text) {
                print("Ошибка: Ячейка \(index) не содержит текст \(text)")
                return false
            }
        }
        return true
    }
}
