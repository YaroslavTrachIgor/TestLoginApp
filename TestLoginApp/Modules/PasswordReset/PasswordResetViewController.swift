//
//  PasswordResetViewController.swift
//  TestLoginApp
//
//  Created by User on 2023-09-29.
//

import UIKit
import Combine

//MARK: - Main ViewController
final class PasswordResetViewController: UIViewController {

    private var viewModel = PasswordResetViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet weak var footerLabel: UILabel!
    @IBOutlet weak var recoveryEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        viewModel.$passwordResetTapped
            .sink { [weak self] passwordResetTapped in
                if passwordResetTapped {
                    self?.presentAlertVC(title: "Success", message: "Password Reset Email was sent to your Email Address")
                }
            }
            .store(in: &cancellables)
        viewModel.$popToLogin
            .sink { [weak self] popToLogin in
                if popToLogin {
                    self?.presentLoginVC()
                }
            }
            .store(in: &cancellables)
    }
    
    @IBAction func goBackToLogin(_ sender: Any) {
        viewModel.goBackToLogin()
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        guard let email = recoveryEmailTextField.text, !email.isEmpty else {
            viewModel.errorMessage = "Enter your Email address."
            return
        }
        
        viewModel.reset(email: email)
    }
    
    @IBAction func resend(_ sender: Any) {
        guard let email = recoveryEmailTextField.text, !email.isEmpty else {
            viewModel.errorMessage = "Enter your Email address."
            return
        }
        
        viewModel.reset(email: email)
    }
}

//MARK: - Main methods
private extension PasswordResetViewController {
    func presentLoginVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func prepareUI() {
        recoveryEmailTextField.setupBaseCredetianalsTextField(placeholder: "Email")
    }
    
    func presentAlertVC(title: String, message: String?) {
        AlertManager.presentBaseAlert(title: title, message: message, on: self)
    }
}
