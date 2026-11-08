//
//  CityViewController.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 08.02.2026.
//

import UIKit
import _LocationEssentials
import CoreLocation

@MainActor
final class CityViewController: UIViewController {
    
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var getWeatherButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    let service = NetworkService()
    let viewModel = CityViewModel()
    
    var locationService: LocationServiceProtocol = LocationService()
    var forecast: [WeatherData] = []
    var locationCoordinates: CLLocationCoordinate2D?
    var city: String { cityField.text ?? "" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // реализация функции тапа на кнопку получения погоды
    @IBAction func getWeatherByCityButtonTapped(_ sender: UIButton) {
        Task {
            do {
                loader.isHidden = false
                forecast = try await viewModel.getWeather(city: city)
                loader.isHidden = true
                
                performSegue(withIdentifier: "goToWeatherScreen", sender: self)
                
                cityField.text = nil
            } catch let error as GetWeatherError {
                errorLabel.text = error.errorDescription
                errorLabel.isHidden = false
                loader.isHidden = true
            } catch {
                errorLabel.text = "Unknown error"
                errorLabel.isHidden = false
                loader.isHidden = true
            }
        }
    }
    
    // нажатие на кнопку получения погоды по геолокации
    @IBAction func getWeatherByLocationButtonTapped(_ sender: Any) {
        loader.isHidden = false
        
        Task {
            do {
                locationCoordinates = try await locationService.requestLocation()
                
                guard let locationCoordinates = locationCoordinates else {
                    errorLabel.text = "Don't know your location. Try again."
                    loader.isHidden = true
                    
                    return
                }
                
                forecast = try await viewModel.getWeatherByLocation(
                    lat: locationCoordinates.latitude,
                    lon: locationCoordinates.longitude
                )
                
                loader.isHidden = true
                
                performSegue(withIdentifier: "goToWeatherScreen", sender: self)
            } catch let locationError as LocationError {
                errorLabel.isHidden = false
                loader.isHidden = true
                
                switch locationError {
                case .permissionDenied:
                    errorLabel.text = "Access denied"
                
                case .noLocation:
                    errorLabel.text = "Can't find location"
                
                case .unknown:
                    errorLabel.text = "Unknown location error"
                }
            } catch let error as GetWeatherError {
                errorLabel.text = error.errorDescription
                errorLabel.isHidden = false
                loader.isHidden = true
            } catch {
                errorLabel.isHidden = false
                errorLabel.text = "Unknown error"
                loader.isHidden = true
            }
        }
    }
    
    // подпись на событие editingDidBegin поля ввода города
    @IBAction func editingDidBegin(_ sender: Any) {
        errorLabel.isHidden = true
    }
    
    // реализация функции тапа на кнопку выхода из аккаунта
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Функция передает переменные на следующий экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWeatherScreen" {
            let destinationVC = segue.destination as! WeatherViewController
            
            destinationVC.forecast = self.forecast
            
            if city.isEmpty { destinationVC.city = " your location"} else { destinationVC.city = self.city }
        }
    }
    
    // событие тача (деактивация полей)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        errorLabel.isHidden = true
    }
}

// расширяем вью-контроллер для реализации скрытие клавы в делегате
extension CityViewController: UITextFieldDelegate {
    // Срабатывает в момент нажатия на текстовое поле нужен для скрытие клавиатуры
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorLabel.isHidden = true
    }
    
    // скрывает клавиатуру после нажатия на кнопку enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

