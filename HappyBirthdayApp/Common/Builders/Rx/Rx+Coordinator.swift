//
//  Rx+Coordinator.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 07/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base == Coordinators.Base {
    
    var pop: Binder<Bool> {
        return Binder(self.base) { _, animated in
            base.navigationController.popViewController(animated: animated)
        }
    }
}
