//
//  MockWeatherResponseService.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 11.07.2026.
//

@testable import get_weather_app
import XCTest
import Alamofire

@MainActor
final class MockNetworkService: NetworkService {
    private let decoder = JSONDecoder()
    private let decoderMockService = DecoderMockService()
    
    override func getWeatherByCredentials(lat: Double, lon: Double) async throws -> Temperature {
        let response = decoderMockService.loadDataFromJSON(fileName: "ResponseGETWeather")
        
        // декодинг в json по заранее созданной структурет WeatherResponse
        let data = try decoder.decode(WeatherResponse.self, from: response)
        
        return data.hourly
    }
    
    override func getCredentials(city: String) async throws -> Weather {
        // отправляет запрос и заносит ответ в переменную response
        let response = decoderMockService.loadDataFromJSON(fileName: "ResponseGETCredentials")
        
        // декодинг в json по заранее созданной структурет CityResult
        let data = try decoder.decode(CityResult.self, from: response)
        
        guard let credentials = data.results.first else {
            throw AFError.responseValidationFailed(reason: .dataFileNil)
        }
        
        return credentials
    }
}
