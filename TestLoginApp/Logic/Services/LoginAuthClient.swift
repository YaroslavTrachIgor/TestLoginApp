//
//  LoginAuthClient.swift
//  TestLoginApp
//
//  Created by User on 2023-10-07.
//

import Foundation

//MARK: - LoginAuth Service protocol
protocol LoginAuthClientProtocol {
    func loginWith(email: String, password: String, completion: @escaping BaseErrorCompletionHandler)
}


//MARK: - Main LoginAuth Service
final class LoginAuthClient: AuthManager, LoginAuthClientProtocol {
    
    //MARK: Internal
    func loginWith(email: String, password: String, completion: @escaping BaseErrorCompletionHandler) {
        login(email: email, password: password, completion: completion)
    }
}
