//
//  LocationServiceMock.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 30.05.2026.
//

import CoreLocation
@testable import get_weather_app

final class MockLocationService: LocationServiceProtocol {

    var coordinate = CLLocationCoordinate2D(latitude: 50.0, longitude: 80.0)
    var error: Error?

    func requestLocation() async throws -> CLLocationCoordinate2D {
        if let error {
            throw error
        }
        
        return coordinate
    }
}
