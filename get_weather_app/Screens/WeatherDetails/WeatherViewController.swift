//
//  WeatherViewController.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 08.02.2026.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var todayInLabel: UILabel!
    
    let viewModel: WeatherViewModel = WeatherViewModel()
    let service = NetworkService()
    var city: String = ""
    var forecast: [WeatherData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("1. viewDidLoad Иерархия создана, но экран еще не виден")
        
        // скорее всего нужно будет перенести на прошлый экран после нажатия на кнопку и выводить валидацию в случае ошибки. доделать
        Task {
            do {
                forecast = try await service.getWeather(city: city)
            } catch {
                print("Не прошла валидация данных", error)
            }
        }
        
        tableView.accessibilityIdentifier = "weather_table_view"
        
        // Привязка контроллера, задающего данные для таблицы
        tableView.dataSource = self
        
        todayInLabel.text = "Today in \(city)"
    }
    
    // расчет количества строк, которые необходимо отрисовать
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.count
    }
    
    // определяет что именно отрисовывается в каждой ячейке таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        
        let weather = forecast[indexPath.row]
        cell.textLabel?.text = "\(weather.timeOfDay): \(weather.temp)"
        
        cell.accessibilityIdentifier = "weather_cell_\(indexPath.row)"
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2. viewWillAppear Экран почти загрузился")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("3. viewDidAppear Экран полностью отрисован. Можно запускать анимашки")
    }
    
    // реализация перехода на предыдущий экран
    @IBAction func backButtonPressed(_ sender: Any) {
        // удаляет текущий экран и возвращает на предыдущий
        print("Нажата кнопка Назад")
        self.navigationController?.popViewController(animated: true)
    }
}
