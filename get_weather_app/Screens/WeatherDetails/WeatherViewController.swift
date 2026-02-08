//
//  WeatherViewController.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 08.02.2026.
//

import UIKit

class WeatherViewController: UIViewController {

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

}
