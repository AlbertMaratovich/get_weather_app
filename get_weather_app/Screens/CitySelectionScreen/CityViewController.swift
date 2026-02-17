//
//  CityViewController.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 08.02.2026.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var getWeatherButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1. viewDidLoad Иерархия создана, но экран еще не виден")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2. viewWillAppear Экран почти загрузился")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("3. viewDidAppear Экран полностью отрисован. Можно запускать анимашки")
    }
    
    // реализация функции тапа на кнопку получения погоды
    @IBAction func getWeatherButtonTapped(_ sender: UIButton) {
        print("Нажата получения погоды")
        
        let city = cityField.text ?? ""
        
        if self.validateCity(city: city) {
            performSegue(withIdentifier: "goToWeatherScreen", sender: self)
        } else {
            print("Validation error")
        }
    }
    
    // реализация функции тапа на кнопку выхода из аккаунта
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        // удаляет текущий экран и возвращает на предыдущий
        print("Нажата кнопка Выйти")
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // валидация города
    private func validateCity(city: String) -> Bool {
        if city.isEmpty { return false }
        
        return city.allSatisfy { $0.isLetter && $0.isASCII }
    }
    
    // Функция передает переменные на следующий экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWeatherScreen" {
            let destinationVC = segue.destination as! WeatherViewController
            destinationVC.city = cityField.text ?? ""
        }
    }
    
}
