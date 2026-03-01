//
//  CityViewModel.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 08.02.2026.
//

struct CityViewModel {
    // валидация города
    func validateCity(city: String) -> Bool {
        if city.isEmpty { return false }
        return city.allSatisfy { $0.isLetter && $0.isASCII }
    }
}
