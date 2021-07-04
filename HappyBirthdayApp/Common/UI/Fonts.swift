//
//  Fonts.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import UIKit

extension UIFont {
    enum App {
        case header1
        case header2
        case text1
        
        var value: UIFont {
            switch self {
            case .header1: return UIFont.boldSystemFont(ofSize: 50)
            case .header2: return UIFont.boldSystemFont(ofSize: 25)
            case .text1: return UIFont.systemFont(ofSize: 12)
            }
        }
    }
}
