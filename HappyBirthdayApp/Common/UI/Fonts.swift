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
        case header3
        case text1
        case text2
        
        var value: UIFont {
            switch self {
            case .header1: return UIFont.boldSystemFont(ofSize: 50)
            case .header2: return UIFont.boldSystemFont(ofSize: 25)
            case .header3: return UIFont.boldSystemFont(ofSize: 21)
            case .text1: return UIFont.systemFont(ofSize: 12)
            case .text2: return UIFont.systemFont(ofSize: 16)
            }
        }
    }
}
