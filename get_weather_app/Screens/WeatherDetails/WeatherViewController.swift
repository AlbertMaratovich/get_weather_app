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
    
    let service = NetworkService()
    var city: String = ""
    var forecast: [WeatherData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("1. WeatherViewController viewDidLoad Иерархия создана, но экран еще не виден")
        tableView.accessibilityIdentifier = "weather_table_view"
        
        // Привязка контроллера, задающего данные для таблицы
        tableView.dataSource = self
        
        todayInLabel.text = "Today in \(city)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2. WeatherViewController viewWillAppear Экран почти загрузился")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("3. WeatherViewController viewDidAppear Экран полностью отрисован. Можно запускать анимашки")
    }
    
    // расчет количества строк, которые необходимо отрисовать
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(forecast.count)
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
    
    // реализация перехода на предыдущий экран
    @IBAction func backButtonPressed(_ sender: Any) {
        // удаляет текущий экран и возвращает на предыдущий
        print("Нажата кнопка Назад")
        self.navigationController?.popViewController(animated: true)
    }
    
    // реализация жеста свайп-бэк
    @IBAction func swipeToCityView(_ sender: Any) {
        print("Выполнен жест назад")
        self.navigationController?.popViewController(animated: true)
    }
}
