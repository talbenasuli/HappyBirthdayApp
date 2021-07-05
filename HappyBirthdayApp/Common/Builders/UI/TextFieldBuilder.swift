//
//  TextFieldBuilder.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import UIKit

extension UITextField {
    
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    func placeHolder(_ string: String) -> Self {
        placeholder = string
        return self
    }
    
    func delegate(_ delegate: UITextFieldDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    func inputView(_ view: UIView) -> Self {
        inputView = view
        return self
    }
}
