//
//  RegisterViewModel.swift
//  TestLoginApp
//
//  Created by User on 2023-09-29.
//

import Foundation
import FirebaseAuth
import Combine

//MARK: - ViewModel protocol
protocol RegisterViewModelProtocol {
    func login(email: String, password: String)
    func backToSignUp()
    func forgotPassword()
}


//MARK: - Main ViewModel
final class RegisterViewModel {
    
    private var authClient: LoginAuthClientProtocol? {
        return LoginAuthClient()
    }
    
    @Published var isLoggedIn: Bool = false
    @Published var hasAnAccount: Bool = true
    @Published var goToPasswordReset: Bool = false
    @Published var errorMessage: String?
    
    func login(email: String, password: String) {
        authClient?.loginWith(email: email, password: password, completion: { [weak self] error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.isLoggedIn = true
            }
        })
    }
    
    func backToSignUp() {
        hasAnAccount = false
    }
    
    func forgotPassword() {
        goToPasswordReset = true
    }
}
