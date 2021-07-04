//
//  HomeCoordinator.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import Foundation

extension Coordinators {
    enum Home { }
}

extension Coordinators.Home {
    
    final class Coordinator: Coordinators.Base {
        
        override func start() {
            navigationController.viewControllers.removeAll()
            show(ViewController())
        }
    }
}
