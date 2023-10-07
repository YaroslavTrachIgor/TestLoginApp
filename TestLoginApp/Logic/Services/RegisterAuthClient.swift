//
//  RegissterAuthClient.swift
//  TestLoginApp
//
//  Created by User on 2023-10-07.
//

import Foundation

//MARK: - Register Auth Service protocol
protocol RegisterAuthClientProtocol {
    func registerWith(email: String, password: String, completion: @escaping BaseErrorCompletionHandler)
}


//MARK: - Main Register Auth Service
final class RegisterAuthClient: AuthManager, RegisterAuthClientProtocol {
    
    //MARK: Internal
    func registerWith(email: String, password: String, completion: @escaping BaseErrorCompletionHandler) {
        register(email: email, password: password, completion: completion)
    }
}
