//
//  AlertBuilder.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import UIKit

extension UIAlertController {
    
    func add(_ action: UIAlertAction) -> Self {
        self.addAction(action)
        return self
    }
    
    func add(_ actions: [UIAlertAction]) -> Self {
        for action in actions {
            self.addAction(action)
        }
        return self
    }
}
