//
//  HomeCoordinator.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import UIKit
import RxCocoa
import RxSwift

extension Coordinators {
    enum Home { }
}

extension Coordinators.Home {
    
    final class Coordinator: Coordinators.Base {
        
        private var imagePickerCoordinator: Coordinators.ImagePicker.Coordinator?
                
        override func start() {
            navigationController.viewControllers.removeAll()
            showDetails()
        }
    }
}

private extension Coordinators.Home.Coordinator {
    
    func showDetails() {
        let vm = Details.ViewModel()
        
        vm.firstActionTapped
            .drive(onNext: { [weak vm] in
                guard let vm = vm else { return }
                self.showImagePicker(with: vm, sourceType: .camera)
            }).disposed(by: vm.disposeBag)
        
        vm.secondActionTapped
            .drive(onNext: { [weak vm] in
                guard let vm = vm else { return }
                self.showImagePicker(with: vm, sourceType: .photoLibrary)
            }).disposed(by: vm.disposeBag)
        
        vm.onNextTapped
            .subscribe(onNext: { (birthDate, name) in
                self.showHappyBirthday(with: birthDate, and: name)
            }).disposed(by: vm.disposeBag)
        
        let vc = Details.ViewController(with: vm)
        show(vc)
    }
    
    func showImagePicker(with viewModel: Details.ViewModel, sourceType: UIImagePickerController.SourceType) {
        guard let presenting = navigationController.viewControllers.last else { return }
        let coordinator = Coordinators.ImagePicker.Coordinator(with: sourceType, presentationStyle: .present(presenting: presenting))
        self.imagePickerCoordinator = coordinator
        
        coordinator.image
            .drive(onNext: { image in
                viewModel.selectedImage.accept(image)
                self.imagePickerCoordinator = nil
            }).disposed(by: viewModel.disposeBag)
        
        coordinator.start()
    }
    
    func showHappyBirthday(with birthDate: Date, and name: String) {
        let vm = HappyBirthday.ViewModel(birthDate: birthDate, name: name)
        let randomNumber = Int.random(in: 0...2)
        guard let style = HappyBirthday.ViewController.Style(rawValue: randomNumber) else { return }
        
        vm.backTapped
            .map { return true }
            .bind(to: (self as Coordinators.Base).rx.pop)
            .disposed(by: vm.disposeBag)
        
        let vc = HappyBirthday.ViewController(with: vm, style: style)
        show(vc)
    }
}
