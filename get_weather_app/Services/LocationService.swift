//
//  LocationService.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 09.03.2026.
//

import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol {
    private let manager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocationCoordinate2D, Error>?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() async throws -> CLLocationCoordinate2D {
        let status = manager.authorizationStatus

        switch status {
        case .notDetermined:
            return try await withCheckedThrowingContinuation { continuation in
                self.continuation = continuation
                manager.requestWhenInUseAuthorization()
            }
            
        case .denied, .restricted:
            throw LocationError.permissionDenied
            
        case .authorizedAlways, .authorizedWhenInUse:
            return try await withCheckedThrowingContinuation { continuation in
                self.continuation = continuation
                manager.desiredAccuracy = kCLLocationAccuracyBest
                manager.startUpdatingLocation()
            }
            
        @unknown default:
            throw LocationError.unknown
        }
    }

    // MARK: - CLLocationManagerDelegate (Разрешения)

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
            
        case .denied, .restricted:
            continuation?.resume(throwing: LocationError.permissionDenied)
            continuation = nil
            
        case .notDetermined:
            break
            
        @unknown default:
            break
        }
    }

    // MARK: - CLLocationManagerDelegate (Координаты)

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        manager.stopUpdatingLocation()
        
        continuation?.resume(returning: location.coordinate)
        continuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        
        if let clError = error as? CLError {
            switch clError.code {
            case .denied:
                continuation?.resume(throwing: LocationError.permissionDenied)
            case .locationUnknown:
                continuation?.resume(throwing: LocationError.noLocation)
            default:
                continuation?.resume(throwing: LocationError.unknown)
            }
        } else {
            continuation?.resume(throwing: LocationError.unknown)
        }
        continuation = nil
    }
}

// MARK: - Errors
enum LocationError: Error {
    case permissionDenied
    case noLocation
    case unknown
}
