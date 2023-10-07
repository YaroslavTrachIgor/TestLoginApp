//
//  AlertManager.swift
//  TestLoginApp
//
//  Created by User on 2023-10-07.
//

import Foundation
import UIKit

//MARK: - Main Manager
final public class AlertManager {
    
    //MARK: Static
    static func presentBaseAlert(title: String?, message: String?, on vc: UIViewController) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel))
        vc.present(alertVC, animated: true)
    }
}
