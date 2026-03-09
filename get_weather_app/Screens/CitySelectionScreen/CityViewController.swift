//
//  CityViewController.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 08.02.2026.
//

import UIKit
import _LocationEssentials
import CoreLocation

class CityViewController: UIViewController {
    
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var getWeatherButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var validationErrorLabel: UILabel!
    @IBOutlet weak var cityLoader: UIActivityIndicatorView!
    
    let service = NetworkService()
    let cityViewModel = CityViewModel()
    var forecast: [WeatherData] = []
    let locationService = LocationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityField.delegate = self
        
        print("1. CityViewController viewDidLoad Иерархия создана, но экран еще не виден")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2. CityViewController viewWillAppear Экран почти загрузился")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("3. CityViewController viewDidAppear Экран полностью отрисован. Можно запускать анимашки")
    }
    
    // реализация функции тапа на кнопку получения погоды
    @IBAction func getWeatherButtonTapped(_ sender: UIButton) {
        print("Нажата получения погоды")
        
        let city = cityField.text ?? ""
        
        if cityViewModel.validateCity(city: city) {
            Task {
                do {
                    cityLoader.isHidden = false
                    forecast = try await service.getWeather(city: city)
                    print("Отправляем запрос за погодой")
                    performSegue(withIdentifier: "goToWeatherScreen", sender: self)
                    cityLoader.isHidden = true
                } catch {
                    print("Не прошла валидация данных", error)
                    validationErrorLabel.text = "Can't find this city. Try again"
                    validationErrorLabel.isHidden = false
                    cityLoader.isHidden = true
                }
            }
        } else {
            print("Validation error")
            validationErrorLabel.text = "Please enter the valid city name"
            validationErrorLabel.isHidden = false
        }
    }
    
    // подпись на событие editingDidBegin поля ввода города
    @IBAction func editingDidBegin(_ sender: Any) {
        validationErrorLabel.isHidden = true
    }
    
    // реализация функции тапа на кнопку выхода из аккаунта
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        // удаляет текущий экран и возвращает на предыдущий
        print("Нажата кнопка Выйти")
        self.navigationController?.popViewController(animated: true)
    }
    
    // Функция передает переменные на следующий экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWeatherScreen" {
            let destinationVC = segue.destination as! WeatherViewController
            destinationVC.city = cityField.text ?? ""
            destinationVC.forecast = forecast
        }
    }
    
    // нажатие на кнопку получения погоды по геолокации
    @IBAction func getCityByLocation(_ sender: Any) {
        print("Нажата получения погоды по геолокации")

        Task {
            do {
                cityLoader.isHidden = false
                
                let coordinate = try await locationService.requestLocation()
                print("Отправляем запрос пермишена")
                
                forecast = try await service.getWeatherByGeo(lat: coordinate.latitude, lon: coordinate.longitude)
                print("Отправляем запрос за погодой")
                
                performSegue(withIdentifier: "goToWeatherScreen", sender: self)
                
                cityLoader.isHidden = true
            } catch let locationError as LocationError{
                validationErrorLabel.isHidden = false
                cityLoader.isHidden = true
                
                switch locationError {
                case .permissionDenied:
                    print("Пользователь запретил доступ к геолокации")
                    validationErrorLabel.text = "Access denied"
                case .noLocation:
                    print("Не удалось определить координаты")
                    validationErrorLabel.text = "Can't define location"
                case .unknown:
                    print("Неизвестная ошибка геолокации")
                    validationErrorLabel.text = "Unknown locationerror"
                }
            } catch {
                validationErrorLabel.isHidden = false
                cityLoader.isHidden = true
                validationErrorLabel.text = "Can't find this city. Try again"
                
                print("Сетевая ошибка:\n", error)
            }
        }
    }
    
    // событие тача
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Это снимет курсор и деактивирует поле
        view.endEditing(true)
    }
}

// расширяем вью-контроллер для реализации скрытие клавы в делегате
extension CityViewController: UITextFieldDelegate {
    // Срабатывает в момент нажатия на текстовое поле нужен для скрытие клавиатуры
    func textFieldDidBeginEditing(_ textField: UITextField) {
        validationErrorLabel.isHidden = true
    }
    
    // скрывает клавиатуру после нажатия на кнопку enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // заставляет текстовое поле "отдать" фокус и спрятать клавиатуру
        textField.resignFirstResponder()
        return true
    }
}

