//
//  CoordinatorType.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import UIKit

enum Coordinators { }

extension Coordinators {
    
    enum PresentationStyle {
        case present(presenting: UIViewController)
        case push(navigation: UINavigationController)
        case window(UIWindow)
    }
}

protocol CoordinatorType: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
}

