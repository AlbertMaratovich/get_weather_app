//
//  LoginScreenViewModelTests.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 11.05.2026.
//
import XCTest
@testable import get_weather_app

final class LoginViewModelTests: BaseUnitTest {
    var viewModel = LoginViewModel()
    
    func testCanLoginWithValidData() {
        XCTAssertTrue(viewModel.canLogin(user: "user", pass: "123456"))
    }
    
    func testCanNotLoginWithWrongPassword() {
        XCTAssertFalse(viewModel.canLogin(user: "user", pass: "12345"))
    }
    
    func testCanNotLoginWithWrongEmail() {
        XCTAssertFalse(viewModel.canLogin(user: "userr", pass: "123456"))
    }
}
