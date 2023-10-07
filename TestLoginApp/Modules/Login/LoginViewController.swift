//
//  LoginViewController.swift
//  TestLoginApp
//
//  Created by User on 2023-09-18.
//

import UIKit
import Combine

//MARK: - Main ViewController
final class LoginViewController: UIViewController {
    
    private var viewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var confirmPasswoed: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UITextView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        viewModel.$errorMessage
            .sink { [weak self] errorMessage in
                self?.errorMessageLabel.text = errorMessage
                self?.errorMessageLabel.isHidden = false
            }
            .store(in: &cancellables)
        
        viewModel.$isRegistered
            .sink { [weak self] isRegistered in
                if isRegistered {
                    self?.presentAlertVC(title: "Success", message: "You are Registered now.")
                    self?.errorMessageLabel.isHidden = true
                }
            }
            .store(in: &cancellables)
        
        viewModel.$hasAnAccount
            .sink { [weak self] hasAnAccount in
                if hasAnAccount {
                    self?.presentLoginVC()
                }
            }
            .store(in: &cancellables)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func register(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else {
            viewModel.errorMessage = "Enter your Email address."
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            viewModel.errorMessage = "Enter your new password."
            return
        }
        
        guard let password = passwordTextField.text,
              let confirmedPassword = confirmPasswoed.text,
              password == confirmedPassword else {
            viewModel.errorMessage = "Passwords do not match."
            return
        }
        
        viewModel.register(email: email, password: password)
    }
    
    @IBAction func login(_ sender: Any) {
        viewModel.login()
    }
}


//MARK: - Main methods
private extension LoginViewController {
    func prepareUI() {
        emailTextField.setupBaseCredetianalsTextField(placeholder: "Email")
        passwordTextField.setupBaseCredetianalsTextField(placeholder: "Password")
        confirmPasswoed.setupBaseCredetianalsTextField(placeholder: "Confirm Password")
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func presentLoginVC() {
        let registerVC = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func presentAlertVC(title: String, message: String) {
        AlertManager.presentBaseAlert(title: title, message: message, on: self)
    }
}
