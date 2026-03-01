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
    @IBOutlet weak var loginErrorLabel: UILabel!
    @IBOutlet weak var accountCredentials: UILabel!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        accountCredentials.text = "Валидные данные для входа:\nЛогин: user \nПароль: 123456"
        print("1. LoginViewController viewDidLoad Иерархия создана, но экран еще не виден")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2. LoginViewController viewWillAppear Экран почти загрузился")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("3. LoginViewController viewDidAppear Экран полностью отрисован. Можно запускать анимашки")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // закрывает клавиатуру после тапа на свободную область
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let user = loginTextField.text ?? ""
        let pass = passwordTextField.text ?? ""
        
        if viewModel.canLogin(user: user, pass: pass) {
            print("Переход на главный экран")
            performSegue(withIdentifier: "goToCitySelection", sender: self)
        } else {
            print("Неверные данные")
            loginErrorLabel.isHidden = false
        }
    }
}

// расширяем вью-контроллер для реализации делегата
extension LoginViewController: UITextFieldDelegate {
    // Срабатывает в момент нажатия на текстовое поле
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginErrorLabel.isHidden = true
    }
    
    // скрывает клавиатуру после нажатия на кнопку enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // заставляет текстовое поле "отдать" фокус и спрятать клавиатуру
        textField.resignFirstResponder()
        return true
    }
}
