//
//  HomeViewModelType.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import Foundation
import RxCocoa
import RxSwift

protocol DetailsViewModelType {
    
    //input
    var titleText: BehaviorRelay<String> { get }
    var firstDetail: BehaviorRelay<String> { get }
    var dateDetail: BehaviorRelay<String> { get }
    
    //output
    var titlePlaceHolder: String { get }
    var firstDetailPlaceHolder: String { get }
    var dateDetailPlaceHolder: String { get }
    var nextButtonTitle: String { get }
    var nextButtonEnable: Driver<Bool> { get }
}
