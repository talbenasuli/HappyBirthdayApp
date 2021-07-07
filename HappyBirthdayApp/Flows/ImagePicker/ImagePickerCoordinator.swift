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
                
        private let _image = PublishRelay<UIImage>()
        lazy var image = _image.asDriver(onErrorDriveWith: .never())
        
        override func start() {
            showActions()
        }
    }
}

private extension Coordinators.ImagePicker.Coordinator {
    
    func showActions() {
        let cancelAction =  UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        let openCameraAction = UIAlertAction(title: "Take A Photo", style: .default) { action in
            self.showImagePicker(with: .camera)
        }
        
        let openGaleryAction = UIAlertAction(title: "Choose A Photo", style: .default) { action in
            self.showImagePicker(with: .photoLibrary)
        }
        let actions = [openCameraAction, openGaleryAction, cancelAction]
        
        let alertContoller = UIAlertController(title: "Please Choose", message: "", preferredStyle: .actionSheet)
            .add(actions)
        
        switch presentationStyle {
        case .present(let presenting): presenting.present(alertContoller, animated: true)
        default: break
        }
    }
    
    
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

