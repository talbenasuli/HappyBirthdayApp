//
//  Coordinator.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import UIKit

extension Coordinators {
    
    class Base: NSObject, CoordinatorType {
        
        var navigationController = UINavigationController()
        let presentationStyle: PresentationStyle
        private var didShowFirst: Bool = false
        
        init(presentationStyle: PresentationStyle) {
            self.presentationStyle = presentationStyle
        }
        
        func start() { }
        
        func show(_ viewController: UIViewController,
                  animated: Bool = true,
                  modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
            
            if !didShowFirst {
                showFirst(viewController, animated: animated, modalPresentationStyle: modalPresentationStyle)
            } else {
                navigationController.pushViewController(viewController, animated: animated)
            }
        }
        
        func dismissCoordinator(animated: Bool = true, completion: (() -> Void)? = nil) {
            
            switch presentationStyle {
            case .present:
                navigationController.dismiss(animated: animated, completion: completion)
            case .push:
                navigationController.popToRootViewController(animated: animated)
                completion?()
            case .window:
                break
            }
        }
        
        private func showFirst(_ viewController: UIViewController,
                               animated: Bool,
                               modalPresentationStyle: UIModalPresentationStyle) {
            switch presentationStyle {
            case .present(let presenting):
                    
                if let navigation = viewController as? UINavigationController {
                    navigationController = navigation
                } else {
                    navigationController = UINavigationController(rootViewController: viewController)
                }
             
                navigationController.modalPresentationStyle = modalPresentationStyle
                presenting.present(navigationController, animated: animated)
                
            case .push(let navigation):
                navigationController = navigation
                navigationController.pushViewController(viewController, animated: true)
                
            case .window(let window):
                let nvc = UINavigationController(rootViewController: viewController)
                navigationController = nvc
                window.makeKeyAndVisible()
                window.rootViewController = navigationController
            }
            
            didShowFirst = true
        }
    }
}
