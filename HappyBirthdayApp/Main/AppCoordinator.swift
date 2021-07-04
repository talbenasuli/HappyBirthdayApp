//
//  AppCoordinator.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import UIKit

extension Coordinators {
    enum App { }
}

extension Coordinators.App {
    
    final class Coordinator: Coordinators.Base {
        
        override func start() {
            showSplash()
        }
    }
}

private extension Coordinators.App.Coordinator {
    
    private func showSplash() {
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Splash")
        show(vc)
        showHome()
    }
    
    func showHome() {
        guard let presenting = navigationController.viewControllers.first else { return }
        Coordinators.Home.Coordinator(presentationStyle: .present(presenting: presenting)).start()
    }
}
