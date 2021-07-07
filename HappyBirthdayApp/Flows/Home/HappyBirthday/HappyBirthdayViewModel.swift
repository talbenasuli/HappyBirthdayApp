//
//  HappyBirthdayViewModel.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 06/07/2021.
//

import Foundation
import RxCocoa
import RxSwift

extension HappyBirthday {
    
    final class ViewModel: HappyBirthdayViewModelType {
        
        //input
        var buttonOnCirclTapped = PublishRelay<Void>()
        var backTapped = PublishRelay<Void>()

        //output
        lazy var title: String = name
        var leftImageName: String = "leftSwirls"
        var rightImageName: String = "rightSwirls"
        var numberImageName = BehaviorRelay<String>(value: "")
        var subtitle = BehaviorRelay<String>(value: "")
        var bottomImageName: String = "nanitLogo"
        var buttonTitle: String = "Share the news"
        var selectedImage = PublishRelay<UIImage>()

        var disposeBag = DisposeBag()
        
        private let name: String
        
        init(birthDate: Date, name: String) {
            self.name = name
            setAge(from: birthDate)
        }
    }
}

private extension HappyBirthday.ViewModel {
    
    func setAge(from birthDate: Date) {
        let currentDate = Date()
        
        let years = currentDate.years(from: birthDate)
        let month = currentDate.months(from: birthDate)
        let weeks = currentDate.weeks(from: birthDate)
        let days = currentDate.days(from: birthDate)
        
        if years > 0 {
            numberImageName.accept("\(years)")
            subtitle.accept("YEARS OLD!")
        } else if month > 0 {
            numberImageName.accept("\(month)")
            subtitle.accept("MONTHS OLD!")
        } else if weeks > 0 {
            numberImageName.accept("\(weeks)")
            subtitle.accept("WEEKS OLD!")
        } else {
            numberImageName.accept("\(days)")
            subtitle.accept("DAYS OLD!")
        }
    }
}
