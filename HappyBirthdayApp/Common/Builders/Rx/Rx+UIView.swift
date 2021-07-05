//
//  Rx+UIView.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base == UIViewController {

    var dismiss: Binder<Bool> {
        return Binder(self.base) { viewController, animated in
            viewController.dismiss(animated: animated)
        }
    }
}
