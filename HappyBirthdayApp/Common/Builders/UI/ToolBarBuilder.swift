//
//  ToolBarBuilder.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 07/07/2021.
//

import UIKit

extension UIToolbar {
    
    func barStyle(_ style: UIBarStyle) -> Self {
        barStyle = style
        return self
    }
    
    func isTranslucent(_ translucent: Bool) -> Self {
        isTranslucent = translucent
        return self
    }
    
    func add(buttons: [UIBarButtonItem], animated: Bool = false) -> Self {
        setItems(buttons, animated: animated)
        return self
    }
}
