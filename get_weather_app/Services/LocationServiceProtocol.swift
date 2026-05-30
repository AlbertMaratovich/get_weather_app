//
//  LocationServiceProtocol.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 30.05.2026.
//

import CoreLocation

protocol LocationServiceProtocol {
    func requestLocation() async throws -> CLLocationCoordinate2D
}
