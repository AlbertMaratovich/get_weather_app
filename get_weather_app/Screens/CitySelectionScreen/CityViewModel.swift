//
//  CityViewModel.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 08.02.2026.
//

import Foundation

class CityViewModel {
    let service = NetworkService()
    
    var forecast: [WeatherData] = []
    
    // валидация города
    func validateCity(city: String) -> Bool {
        if city.isEmpty { return false }
        return city.allSatisfy { $0.isLetter && $0.isASCII }
    }
    
    func getWeather(city: String) async throws -> [WeatherData] {
        guard validateCity(city: city) else {
            throw GetWeatherError.invalidCity
        }

        do {
            forecast = try await service.getWeather(city: city)
            
            return forecast
        } catch let error as GetWeatherError {
            throw error
        } catch {
            throw GetWeatherError.networkError(error.localizedDescription)
        }
    }
    
    func getWeatherByLocation(lat: Double, lon: Double) async throws -> [WeatherData] {
        do {
            forecast = try await service.getWeather(lat: lat, lon: lon)
            
            return forecast
        } catch let error as GetWeatherError {
            throw error
        } catch {
            throw GetWeatherError.networkError(error.localizedDescription)
        }
    }
}

enum GetWeatherError: Error, LocalizedError {
    case networkError(String)
    case invalidCity
    
    var errorDescription: String? {
        switch self {
        case .invalidCity:
            return "City validation error"
        case .networkError(let message):
            return "Network error: \(message)"
        }
    }
}
