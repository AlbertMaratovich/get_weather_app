//
//  XCUIElement+Extension.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 25.03.2026.
//

import XCTest

extension XCUIElement {
    
    // пытается очистить текстовое поле дважды, если не получается - фейлит тест
    public func clearText() -> Void {
        self.tap(withNumberOfTaps: 3, numberOfTouches: 1)
        let cutButton = XCUIApplication().menuItems["Cut"]
        
        if cutButton.waitForExistence(timeout: 1) {
            cutButton.tap()
            return
        }
        
        self.tap(withNumberOfTaps: 3, numberOfTouches: 1)
        
        if cutButton.waitForExistence(timeout: 1) {
            cutButton.tap()
        } else {
            XCTFail("Ошибка: не удалось вызвать меню 'Cut' для очистки поля \(self.description) после двух попыток")
        }
    }
    
    // Делает безопасный тап с проверками и ожиданиями доступности элемента
    public func safeTap() -> Void {
        if self.waitForExistence(timeout: 3) {
            if self.isHittable {
                self.tap()
            } else {
                XCTFail(
                    "Ошибка: элемент \(self.description) не доступен для нажатия"
                )
            }
        } else {
            XCTFail(
                "Ошибка: элемент \(self.description) не найден"
            )
        }
    }
}
