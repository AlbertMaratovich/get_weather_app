//
//  Weather.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 08.02.2026.
//

struct CityResult: Codable {
    let results: [Weather]
}

struct Weather: Codable {
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
}

struct WeatherResponse: Codable {
    let hourly: Temperature
}

struct Temperature: Codable {
    let time: [String]
    let temperature_2m: [Float]
}
