//
//  DatePickerBuilder.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import UIKit

extension UIDatePicker {
    
    func mode(_ mode: Mode) -> Self {
        datePickerMode = mode
        return self
    }
    
    func max(date: Date?) -> Self {
        maximumDate = date
        return self
    }
}
