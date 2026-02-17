//
//  LoginViewController.swift
//  get_weather_app
//
//  Created by Albert Gimalov on 07.02.2026.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let viewModel = LoginViewModel()
    
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
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let user = loginTextField.text ?? ""
        let pass = passwordTextField.text ?? ""
        
        if viewModel.canLogin(user: user, pass: pass) {
            
            print("Переход на главный экран")
            
            performSegue(withIdentifier: "goToCitySelection", sender: self)
        } else {
            // можно подумать по поводу реализации какой-то всплывашки
            print("access denied")
        }
    }
}
