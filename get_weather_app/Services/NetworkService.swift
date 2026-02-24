//
//  NetworkService.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 08.02.2026.
//

import Alamofire
import Foundation

class NetworkService {
    let decoder = JSONDecoder()
    
    private func getCredentials(city: String) async throws -> Weather {
        let url = "https://geocoding-api.open-meteo.com/v1/search"
        let parameters: [String: Any] = [
            "name": city,
            "count": 1,
            "format": "json"
            ]
        
        let request = AF.request(url, parameters: parameters)
            
        request.cURLDescription { curl in
            print("----- cURL getCredentials -----")
            print(curl)
        }
        
        let  response = try await request.serializingData().value
        
        if let body = String(data: response, encoding: .utf8) {
            print("----- RESPONSE BODY getCredentials -----")
            print(body)
        }
        
        let data = try decoder.decode(CityResult.self, from: response)
        
        guard let credentials = data.results.first else {
                throw AFError.responseValidationFailed(reason: .dataFileNil)
            }
        print(credentials)
        return credentials
    }
    
    private func getWeatherByCredentials(lat: Double, lon: Double) async throws -> Temperature {
        let url = "https://api.open-meteo.com/v1/forecast"
        let parameters: [String: Any] = [
            "latitude": lat,
            "longitude": lon,
            "hourly": "temperature_2m",
            "timezone": "auto"
        ]
        
        let request = AF.request(url, parameters: parameters)
            
        request.cURLDescription { curl in
            print("----- cURL getWeatherByCredentials -----")
            print(curl)
        }
        
        let response = try await request.serializingData().value
        
        if let body = String(data: response, encoding: .utf8) {
            print("----- RESPONSE BODY getWeatherByCredentials-----")
            print(body)
        }
        
        let data = try decoder.decode(WeatherResponse.self, from: response)
        
        return data.hourly
    }
    
    //
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
        print(forecast)
        return forecast
    }
}
