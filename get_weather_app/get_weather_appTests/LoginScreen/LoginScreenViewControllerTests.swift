//
//  Untitled.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 11.05.2026.
//

import XCTest
@testable import get_weather_app

final class LoginViewControllerTests: BaseUnitTest {
    var sut: LoginViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
        sut.loadViewIfNeeded()
    }
    
    func testCheckErrorLabelShown() {
        sut.loginTextField.text = "wrong"
        sut.passwordTextField.text = "wrong"
        
        sut.loginButtonTapped(UIButton())
        
        XCTAssertFalse(sut.loginErrorLabel.isHidden, "Ошибка логина не отобразилась")
    }
    
    func testErrorLabelHideAfterTap() {
        sut.textFieldDidBeginEditing(UITextField())
        
        XCTAssertTrue(sut.loginErrorLabel.isHidden, "Ошибка логина отобразилась, после тапа")
    }
}
