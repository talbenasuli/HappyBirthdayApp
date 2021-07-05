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
        
        weak var detailsViewModel: Details.ViewModel?
        
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
                self.detailsViewModel = vm
                self.showImagePicker(with: .camera)
            }).disposed(by: vm.disposeBag)
        
        vm.secondActionTapped
            .drive(onNext: { [weak vm] in
                self.detailsViewModel = vm
                self.showImagePicker(with: .photoLibrary)
            }).disposed(by: vm.disposeBag)
        
        let vc = Details.ViewController(with: vm)
        show(vc)
    }
    
    func showImagePicker(with sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = false
            let vc = navigationController.viewControllers.last
            vc?.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension Coordinators.Home.Coordinator: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) { [weak self] in
            guard let image = info[.originalImage] as? UIImage else { return }
            self?.detailsViewModel?.selectedImage.accept(image)
        }
    }
}
