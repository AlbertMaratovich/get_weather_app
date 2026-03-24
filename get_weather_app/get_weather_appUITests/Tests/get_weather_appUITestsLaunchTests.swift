//
//  get_weather_appUITestsLaunchTests.swift
//  get_weather_appUITests
//
//  Created by Albert Gimalov on 07.02.2026.
//


// разобраться кто это вообще и нужно ли
import XCTest

final class get_weather_appUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
