//
//  PasswordResetViewModel.swift
//  TestLoginApp
//
//  Created by User on 2023-09-29.
//

import Foundation
import FirebaseAuth
import Combine

//MARK: - ViewModel protocol
protocol PasswordResetViewModelProtocol {
    func reset(email: String)
    func goBackToLogin()
}


//MARK: - Main ViewModel
final class PasswordResetViewModel {
    
    @Published var passwordResetTapped: Bool = false
    @Published var popToLogin: Bool = false
    @Published var errorMessage: String?
    
    func reset(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.passwordResetTapped = true
            }
        }
    }
    
    func goBackToLogin() {
        popToLogin = true
    }
}
