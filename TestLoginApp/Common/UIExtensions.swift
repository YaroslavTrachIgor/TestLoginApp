//
//  UIExtensions.swift
//  TestLoginApp
//
//  Created by User on 2023-09-29.
//

import Foundation
import UIKit

//MARK: - TextField fast methods
public extension UITextField {
    
    //MARK: Public
    func setupBaseCredetianalsTextField(placeholder: String) {
        let tintColor: UIColor = .white
        self.placeholder = placeholder
        self.tintColor = tintColor
        autocorrectionType = .no
        borderStyle = .none
        textColor = tintColor
    }
}
