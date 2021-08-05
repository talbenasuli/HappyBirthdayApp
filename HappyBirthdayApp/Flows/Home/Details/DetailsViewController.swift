//
//  ViewController.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 04/07/2021.
//

import UIKit
import RxCocoa
import RxSwift
import RxKeyboard
import RxGesture
import RxAppState

extension Details {
    final class ViewController: UIViewController {
        
        private let disposeBag = DisposeBag()
        
        private let scrollView = UIScrollView()
        
        private lazy var titleTextField = UITextField()
            .borderColor(.clear)
            .font(UIFont.App.header2.value)
            .placeHolder(viewModel.titlePlaceHolder)
            .delegate(self)
        
        private lazy var firstDetailTextField = UITextField()
            .borderColor(.clear)
            .font(UIFont.App.text1.value)
            .placeHolder(viewModel.firstDetailPlaceHolder)
            .delegate(self)
        
        private lazy var dateDetailTextField = UITextField()
            .borderColor(.clear)
            .font(UIFont.App.text1.value)
            .placeHolder(viewModel.dateDetailPlaceHolder)
            .inputAccessoryView(doneToolBar)
            .delegate(self)
            .inputView(datePicker)
        
        private lazy var datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
            .mode(.date)
            .max(date: viewModel.maxDate)
            .min(date: viewModel.minDate)

        private let image = UIImageView()
            .image(named: "image_place_holder")
        
        private lazy var nextButton = UIButton(frame: .zero)
            .title(viewModel.nextButtonTitle)
            .font(UIFont.App.text1.value)
            .showsTouchWhenHighlighted(true)
            .titleColor(.systemBlue, for: .normal)
            .titleColor(.lightGray, for: .disabled)
        
        private let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: nil)
        private lazy var doneToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 30))
            .isTranslucent(true)
            .barStyle(.default)
            .add(buttons: [doneBarButton])
            
        private let viewModel: DetailsViewModelType
        
        init(with viewModel: DetailsViewModelType) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
            layoutViews()
            handleKyboard()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            bindViewModel()
            navigation(style: .title("Details", .black, UIFont.App.header2.value))
        }
    }
}
// branch 1
private extension Details.ViewController {
    
    func handleKyboard() {
        RxKeyboard.instance.visibleHeight
          .drive(onNext: { [scrollView] keyboardVisibleHeight in
            let padding = CGFloat(30)
            scrollView.contentInset.bottom = keyboardVisibleHeight + padding
          })
          .disposed(by: disposeBag)
        
        doneBarButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.view.endEditing(true)
            }).disposed(by: disposeBag)
    }
    
    func bindViewModel() {
    
        titleTextField.rx.text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .compactMap({ $0 })
            .distinctUntilChanged()
            .bind(to: viewModel.titleText)
            .disposed(by: disposeBag)
        
        firstDetailTextField.rx.text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .compactMap({ $0 })
            .distinctUntilChanged()
            .bind(to: viewModel.firstDetail)
            .disposed(by: disposeBag)
        
        dateDetailTextField.rx.text
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .compactMap({ $0 })
            .distinctUntilChanged()
            .bind(to: viewModel.dateDetail)
            .disposed(by: disposeBag)
        
        viewModel.nextButtonEnable
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .map { return (self.datePicker.date, self.firstDetailTextField.text ?? "") }
            .bind(to: viewModel.onNextTapped)
            .disposed(by: disposeBag)
        
        datePicker.rx.date
            .bind(to: viewModel.selectedDate)
            .disposed(by: disposeBag)
        
        viewModel.selectedDateString
            .drive(dateDetailTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    func layoutViews() {
        view.add(scrollView)
        scrollView.add(titleTextField, firstDetailTextField, dateDetailTextField, image, nextButton)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(.huge)
            make.leading.equalToSuperview().offset(.medium)
            make.trailing.equalToSuperview().inset(.medium)
        }
        
        firstDetailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(.huge)
            make.leading.trailing.equalTo(titleTextField)
        }
        
        dateDetailTextField.snp.makeConstraints { make in
            make.top.equalTo(firstDetailTextField.snp.bottom).offset(.huge)
            make.leading.trailing.equalTo(firstDetailTextField)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(dateDetailTextField.snp.bottom).offset(.huge)
            make.width.height.equalTo(Padding.huge.rawValue * 3)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(image.snp.bottom).offset(.huge)
            make.bottom.equalToSuperview().offset(.huge)
        }
        
        image.rx.tapGesture()
            .when(.recognized)
            .map({ _ in return })
            .bind(to: viewModel.imageTapped)
            .disposed(by: disposeBag)
        
        viewModel.selectedImage
            .bind(to: image.rx.image)
            .disposed(by: disposeBag)
    }
}

extension Details.ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let count = textField.text?.count ?? 0 + string.count
        if textField === titleTextField {
            return count < 40 || string == ""
        } else {
            return count < 50 || string == ""
        }
    }
}
