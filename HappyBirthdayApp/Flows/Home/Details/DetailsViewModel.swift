//
//  HomeViewModel.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension Details {
    
    final class ViewModel: DetailsViewModelType {
            
        //input
        var titleText       = BehaviorRelay<String>(value: "")
        var firstDetail     = BehaviorRelay<String>(value: "")
        var dateDetail      = BehaviorRelay<String>(value: "")
        var selectedDate    = PublishRelay<Date>()
        var imageTapped     = PublishRelay<Void>()
        var selectedImage   = PublishRelay<UIImage>()
        var onNextTapped    = PublishRelay<(Date, String)>()
        
        //output
        var titlePlaceHolder: String = "App Title"
        var firstDetailPlaceHolder: String = "User Name"
        var dateDetailPlaceHolder: String = "User Birthday"
        var nextButtonTitle: String = "Show birthday screen"
        var alertTitle: String = "Please Choose"
        
        var nextButtonEnable: Driver<Bool>
        var selectedDateString: Driver<String>
        var maxDate: Date? = Date()

        var disposeBag = DisposeBag()
        private var alertDisplayed = false
        
        init() {
            let enableButton = Observable.combineLatest(dateDetail, firstDetail)
                .share()
            
            nextButtonEnable = enableButton
                .map { date, name in
                    return !name.isEmpty && !date.isEmpty
                }.asDriver(onErrorDriveWith: .never())
            
            selectedDateString = selectedDate
                .map { date in
                    return date.to(format: "dd.MM.yy")
                }.asDriver(onErrorDriveWith: .never())
        }
    }
}
