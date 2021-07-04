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
        var titleText   = BehaviorRelay<String>(value: "")
        var firstDetail = BehaviorRelay<String>(value: "")
        var dateDetail  = BehaviorRelay<String>(value: "")
        
        //output
        var titlePlaceHolder: String = "App Title"
        var firstDetailPlaceHolder: String = "User Name"
        var dateDetailPlaceHolder: String = "User Birthday"
        var nextButtonTitle: String = "Show birthday screen"
        var nextButtonEnable: Driver<Bool>
        
        init() {
            
            let enableButton = Observable.combineLatest(dateDetail, firstDetail)
                .share()
            
            nextButtonEnable = enableButton
                .map { date, name in
                    return !name.isEmpty && !date.isEmpty
                }.asDriver(onErrorDriveWith: .never())
        }
    }
}
