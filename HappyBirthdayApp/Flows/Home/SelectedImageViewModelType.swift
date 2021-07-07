//
//  SelectedImageViewModelType.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 07/07/2021.
//

import Foundation
import RxCocoa
import RxSwift

protocol SelectedImageViewModelType {
    var selectedImage: PublishRelay<UIImage> { get }
    var disposeBag: DisposeBag { get }
}
