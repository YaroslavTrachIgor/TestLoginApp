//
//  RegisterViewController.swift
//  TestLoginApp
//
//  Created by User on 2023-09-28.
//

import UIKit
import Combine

//MARK: - Main ViewController
final class RegisterViewController: UIViewController {

    private var viewModel = RegisterViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        viewModel.$errorMessage
            .sink { [weak self] errorMessage in
                if let errorMessage = errorMessage {
                    self?.presentAlertVC(title: "Error", message: errorMessage)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$isLoggedIn
            .sink { [weak self] isLoggedIn in
                if isLoggedIn {
                    self?.presentAlertVC(title: "Success", message: "You are Logged In now.")
                }
            }
            .store(in: &cancellables)
        
        viewModel.$hasAnAccount
            .sink { [weak self] hasAnAccount in
                if !hasAnAccount {
                    self?.presentRegisterVC()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$goToPasswordReset
            .sink { [weak self] goToPasswordReset in
                if goToPasswordReset {
                    self?.presentResetPasswordVC()
                }
            }
            .store(in: &cancellables)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func login(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty else {
            viewModel.errorMessage = "Enter your Email address."
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            viewModel.errorMessage = "Enter your password."
            return
        }
        
        viewModel.login(email: email, password: password)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        viewModel.forgotPassword()
    }
    
    @IBAction func backToSignUp(_ sender: Any) {
        viewModel.backToSignUp()
    }
}


//MARK: - Main methods
private extension RegisterViewController {
    func prepareUI() {
        emailTextField.setupBaseCredetianalsTextField(placeholder: "Email")
        passwordTextField.setupBaseCredetianalsTextField(placeholder: "Password")
    }
    
    func presentRegisterVC() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func presentResetPasswordVC() {
        let nibName = String(describing: PasswordResetViewController.self)
        let passwordResetVC = PasswordResetViewController(nibName: nibName, bundle: nil)
        navigationController?.pushViewController(passwordResetVC, animated: true)
    }
    
    func presentAlertVC(title: String, message: String?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alertVC, animated: true)
    }
}
