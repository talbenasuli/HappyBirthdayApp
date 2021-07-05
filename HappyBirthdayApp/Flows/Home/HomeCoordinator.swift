//
//  HomeCoordinator.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import UIKit
import RxCocoa
import RxSwift

enum Details { }

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
}
