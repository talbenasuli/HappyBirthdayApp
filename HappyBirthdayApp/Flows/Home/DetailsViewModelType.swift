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
    var selectedDate: PublishRelay<Date> { get }
    var imageTapped: PublishRelay<Void> { get }
    var selectedImage: PublishRelay<UIImage> { get }
    
    //output
    var titlePlaceHolder: String { get }
    var firstDetailPlaceHolder: String { get }
    var dateDetailPlaceHolder: String { get }
    var nextButtonTitle: String { get }
    var alertTitle: String { get }
    var actions: [UIAlertAction] { get }
    var nextButtonEnable: Driver<Bool> { get }
    var selectedDateString: Driver<String> { get }
    var displayAlert: Driver<Void> { get }
    var secondActionTapped: Driver<Void> { get }
    var firstActionTapped: Driver<Void> { get }
}
