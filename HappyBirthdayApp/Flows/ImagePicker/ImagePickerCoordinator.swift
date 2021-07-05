//
//  ImagePickerCoordinator.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 06/07/2021.
//

import UIKit
import RxCocoa
import RxSwift

extension Coordinators {
    enum ImagePicker { }
}

extension Coordinators.ImagePicker {
    
    final class Coordinator: Coordinators.Base {
        
        private let sourceType: UIImagePickerController.SourceType
        
        private let _image = PublishRelay<UIImage>()
        lazy var image = _image.asDriver(onErrorDriveWith: .never())
        
        init(with sourceType: UIImagePickerController.SourceType,
             presentationStyle: Coordinators.PresentationStyle) {
            self.sourceType = sourceType
            super.init(presentationStyle: presentationStyle)
        }
        
        override func start() {
            showImagePicker(with: sourceType)
        }
    }
}

private extension Coordinators.ImagePicker.Coordinator {
    
    func showImagePicker(with sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = false
            
            show(imagePicker)
        }
    }
}


extension Coordinators.ImagePicker.Coordinator: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self._image.accept(image)
        }
    }
}

