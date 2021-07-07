//
//  HappyBirthdayViewModelType.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 06/07/2021.
//

import Foundation
import RxCocoa
import RxSwift

protocol HappyBirthdayViewModelType: SelectedImageViewModelType {
    
    //input
    var backTapped: PublishRelay<Void> { get }
    var buttonOnCirclTapped: PublishRelay<Void> { get }
    
    //output
    var title: String { get }
    var numberImageName: BehaviorRelay<String> { get }
    var leftImageName: String { get }
    var rightImageName: String { get }
    var subtitle: BehaviorRelay<String> { get }
    var bottomImageName: String { get }
    var buttonTitle: String { get }
}
