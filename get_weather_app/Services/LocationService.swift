//
//  LocationService.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 09.03.2026.
//

import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate, LocationServiceProtocol {

    let manager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocationCoordinate2D, Error>?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    // MARK: - Async function to get location
    func requestLocation() async throws -> CLLocationCoordinate2D {

        switch manager.authorizationStatus {

        case .denied, .restricted:
            throw LocationError.permissionDenied

        case .authorizedAlways, .authorizedWhenInUse:
            break

        case .notDetermined:
            manager.requestWhenInUseAuthorization()

        @unknown default:
            throw LocationError.unknown
        }

        do {
            return try await withCheckedThrowingContinuation { continuation in
                self.continuation = continuation
                manager.requestLocation()
            }
        } catch let error as CLError {

            switch error.code {

            case .denied:
                throw LocationError.permissionDenied

            case .locationUnknown:
                throw LocationError.noLocation

            default:
                throw LocationError.unknown
            }

        } catch {
            throw LocationError.unknown
        }
    }

    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else {
            continuation?.resume(throwing: LocationError.noLocation)
            continuation = nil
            return
        }
        continuation?.resume(returning: loc.coordinate)
        continuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let continuation = continuation else { return }
        if manager.authorizationStatus == .authorizedWhenInUse ||
           manager.authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        } else if manager.authorizationStatus == .denied || manager.authorizationStatus == .restricted {
            continuation.resume(throwing: LocationError.permissionDenied)
            self.continuation = nil
        }
    }
}

// MARK: - Errors
enum LocationError: Error {
    case permissionDenied
    case noLocation
    case unknown
}
