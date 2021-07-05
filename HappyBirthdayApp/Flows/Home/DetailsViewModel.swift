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
        
        //output
        var titlePlaceHolder: String = "App Title"
        var firstDetailPlaceHolder: String = "User Name"
        var dateDetailPlaceHolder: String = "User Birthday"
        var nextButtonTitle: String = "Show birthday screen"
        var alertTitle: String = "Please Choose"
        var actions: [UIAlertAction]
        
        var nextButtonEnable: Driver<Bool>
        var selectedDateString: Driver<String>
        var displayAlert: Driver<Void>
        var secondActionTapped: Driver<Void>
        var firstActionTapped: Driver<Void>

        let disposeBag = DisposeBag()
        private var alertDisplayed = false
        
        init() {
            
            let _firstActionTapped = PublishRelay<Void>()
            firstActionTapped = _firstActionTapped.asDriver(onErrorDriveWith: .never())
            
            let _secondActionTapped = PublishRelay<Void>()
            secondActionTapped = _secondActionTapped.asDriver(onErrorDriveWith: .never())
            
            let cancelAction =  UIAlertAction(title: "Cancel", style: .default) { _ in }
            
            let openCameraAction = UIAlertAction(title: "Take A Photo", style: .default) { action in
                _firstActionTapped.accept(())
            }
            
            let openGaleryAction = UIAlertAction(title: "Choose A Photo", style: .default) { action in
                _secondActionTapped.accept(())
            }
                
            actions = [openCameraAction, openGaleryAction, cancelAction]
            
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
            
            displayAlert = imageTapped
                .asDriver(onErrorDriveWith: .never())
        }
    }
}
