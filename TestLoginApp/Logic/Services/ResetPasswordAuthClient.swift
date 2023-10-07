//
//  ResetPasswordAuthClient.swift
//  TestLoginApp
//
//  Created by User on 2023-10-07.
//

import Foundation

//MARK: - Reset Password Auth Service protocol
protocol ResetPasswordAuthClientProtocol {
    func resetPasswordWith(email: String, completion: @escaping BaseErrorCompletionHandler)
}


//MARK: - Main Reset Password Auth Service
final class ResetPasswordAuthClient: AuthManager, ResetPasswordAuthClientProtocol {
    
    //MARK: Internal
    func resetPasswordWith(email: String, completion: @escaping BaseErrorCompletionHandler) {
        resetPassword(email: email, completion: completion)
    }
}
