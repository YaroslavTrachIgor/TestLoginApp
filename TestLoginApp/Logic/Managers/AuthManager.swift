//
//  AuthManager.swift
//  TestLoginApp
//
//  Created by User on 2023-10-07.
//

import Foundation
import FirebaseAuth

//MARK: - Base Error completion Handler
typealias BaseErrorCompletionHandler = ((Error?) -> ())


//MARK: - Manager protocol
protocol AuthManagerProtocol {
    func register(email: String, password: String, completion: @escaping BaseErrorCompletionHandler)
    func login(email: String, password: String, completion: @escaping BaseErrorCompletionHandler)
    func resetPassword(email: String, completion: @escaping BaseErrorCompletionHandler)
}


//MARK: - Main Manager
class AuthManager: AuthManagerProtocol {
    
    //MARK: Internal
    func register(email: String, password: String, completion: @escaping BaseErrorCompletionHandler) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            completion(error)
        }
    }
    
    func login(email: String, password: String, completion: @escaping BaseErrorCompletionHandler) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completion(error)
        }
    }
    
    func resetPassword(email: String, completion: @escaping BaseErrorCompletionHandler) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
}
