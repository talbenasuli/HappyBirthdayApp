//
//  HomeCoordinator.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import Foundation

enum Details { }

extension Coordinators {
    enum Home { }
}

extension Coordinators.Home {
    
    final class Coordinator: Coordinators.Base {
        
        override func start() {
            navigationController.viewControllers.removeAll()
            let vm = Details.ViewModel()
            let vc = Details.ViewController(with: vm)
            show(vc)
        }
    }
}
