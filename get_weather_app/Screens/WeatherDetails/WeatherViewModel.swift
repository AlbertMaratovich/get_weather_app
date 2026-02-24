//
//  WeatherViewModel.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 08.02.2026.
//

struct WeatherData {
    let timeOfDay: String
    let temp: String
}

// массив доделать после реализации апихи, пока хардкод
//class WeatherViewModel {
//    let forecast = [
//        WeatherData(timeOfDay: "Morning", temp: "15 °C"),
//        WeatherData(timeOfDay: "Afternoon", temp: "18 °C"),
//        WeatherData(timeOfDay: "Evening", temp: "16 °C"),
//        WeatherData(timeOfDay: "Night", temp: "13 °C")
//    ]
//}

class WeatherViewModel {
    let service = NetworkService()
    var forecast: [WeatherData] = []
    
    func getForecast(city: String) async -> [WeatherData] {
        do {
            forecast = try await service.getWeather(city: city)
        } catch {
            print("Не прошла валидация данных", error)
        }
        return forecast
    }
}
