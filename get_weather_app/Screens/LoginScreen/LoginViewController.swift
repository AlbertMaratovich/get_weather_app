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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // закрывает клавиатуру после тапа на свободную область
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        let user = loginTextField.text ?? ""
        let pass = passwordTextField.text ?? ""
        
        if viewModel.canLogin(user: user, pass: pass) {
            performSegue(withIdentifier: "goToCitySelection", sender: self)
        } else {
            loginErrorLabel.isHidden = false
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    // Срабатывает в момент нажатия на текстовое поле
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginErrorLabel.isHidden = true
    }
    
    // скрывает клавиатуру после нажатия на кнопку enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
