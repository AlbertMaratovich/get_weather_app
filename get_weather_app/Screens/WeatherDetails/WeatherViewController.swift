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
        
        tableView.accessibilityIdentifier = "weather_table_view"
        tableView.dataSource = self
        todayInLabel.text = "Today in \(city)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // реализация перехода на предыдущий экран
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // реализация жеста свайп-бэк
    @IBAction func swipeToCityView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
}
