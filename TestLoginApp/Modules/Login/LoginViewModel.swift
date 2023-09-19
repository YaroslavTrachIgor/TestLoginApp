//
//  LoginViewModel.swift
//  TestLoginApp
//
//  Created by User on 2023-09-29.
//

import Foundation
import FirebaseAuth
import Combine

//MARK: - ViewModel protocol
protocol LoginViewModelProtocol {
    func register(email: String, password: String)
    func login()
}


//MARK: - Main ViewModel
final class LoginViewModel {
    
    @Published var isRegistered: Bool = false
    @Published var hasAnAccount: Bool = false
    @Published var errorMessage: String?
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.isRegistered = true
            }
        }
    }
    
    func login() {
        hasAnAccount = true
    }
}
