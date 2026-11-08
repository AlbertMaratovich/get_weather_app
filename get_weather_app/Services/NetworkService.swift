//
//  NetworkService.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 08.02.2026.
//

import Alamofire
import Foundation

class NetworkService {
    private let decoder = JSONDecoder()
    private let geocodingHost = "https://geocoding-api.open-meteo.com"
    private let weatherHost = "https://api.open-meteo.com"
    private let searchPath = "/v1/search"
    private let forecastPath = "/v1/forecast"
    
    // отправляет запрос за долготой и широтой по названию города
    public func getCredentials(city: String) async throws -> Weather {
        let url = geocodingHost + searchPath
        let parameters: [String: Any] = [
            "name": city,
            "count": 1,
            "format": "json"
        ]
        let request = AF.request(url, parameters: parameters)
        let response = try await request.serializingData().value
        let data = try decoder.decode(CityResult.self, from: response)
        
        guard let credentials = data.results.first else {
            throw AFError.responseValidationFailed(reason: .dataFileNil)
        }

        return credentials
    }
    
    // отправляет запрос по координатам
    public func getWeatherByCredentials(lat: Double, lon: Double) async throws -> Temperature {
        let url = weatherHost + forecastPath
        let parameters: [String: Any] = [
            "latitude": lat,
            "longitude": lon,
            "hourly": "temperature_2m",
            "timezone": "auto"
        ]
        let request = AF.request(url, parameters: parameters)
        let response = try await request.serializingData().value
        let data = try decoder.decode(WeatherResponse.self, from: response)
        
        return data.hourly
    }
    
    public func getWeather(city: String) async throws -> [WeatherData] {
        let credentials = try await getCredentials(city: city)
        let temperature = try await getWeatherByCredentials(lat: credentials.latitude, lon: credentials.longitude)
        
        let morning = String(temperature.temperature_2m[8]) + " °C"
        let afternoon = String(temperature.temperature_2m[13]) + " °C"
        let evening = String(temperature.temperature_2m[19]) + " °C"
        let night = String(temperature.temperature_2m[24]) + " °C"
        let forecast = [
            WeatherData(timeOfDay: "Morning", temp: morning),
            WeatherData(timeOfDay: "Afternoon", temp: afternoon),
            WeatherData(timeOfDay: "Evening", temp: evening),
            WeatherData(timeOfDay: "Night", temp: night)
        ]
        
        return forecast
    }
    
    public func getWeather(lat: Double, lon: Double) async throws -> [WeatherData] {
        let temperature = try await getWeatherByCredentials(lat: lat, lon: lon)
        
        let morning = String(temperature.temperature_2m[8]) + " °C"
        let afternoon = String(temperature.temperature_2m[13]) + " °C"
        let evening = String(temperature.temperature_2m[19]) + " °C"
        let night = String(temperature.temperature_2m[24]) + " °C"
        let forecast = [
            WeatherData(timeOfDay: "Morning", temp: morning),
            WeatherData(timeOfDay: "Afternoon", temp: afternoon),
            WeatherData(timeOfDay: "Evening", temp: evening),
            WeatherData(timeOfDay: "Night", temp: night)
        ]
        
        return forecast
    }
}
