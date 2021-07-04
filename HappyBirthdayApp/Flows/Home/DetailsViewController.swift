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
            .delegate(self)
        
        private let image = UIImageView()
            .image(named: "image_place_holder")
        
        private lazy var nextButton = UIButton(frame: .zero)
            .title(viewModel.nextButtonTitle)
            .font(UIFont.App.text1.value)
            .showsTouchWhenHighlighted(true)
            .titleColor(.systemBlue, for: .normal)
            .titleColor(.lightGray, for: .disabled)
            
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

private extension Details.ViewController {
    
    func handleKyboard() {
        RxKeyboard.instance.visibleHeight
          .drive(onNext: { [scrollView] keyboardVisibleHeight in
            let padding = CGFloat(30)
            scrollView.contentInset.bottom = keyboardVisibleHeight + padding
          })
          .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
    
        titleTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.titleText)
            .disposed(by: disposeBag)
        
        firstDetailTextField.rx.text
            .orEmpty
            .scan("") { (previous, new) -> String in
                return new.count >= 20 ? previous : new
            }
            .distinctUntilChanged()
            .bind(to: viewModel.firstDetail)
            .disposed(by: disposeBag)
        
        dateDetailTextField.rx.text
            .orEmpty
            .scan("") { (previous, new) -> String in
                return new.count >= 20 ? previous : new
            }
            .distinctUntilChanged()
            .bind(to: viewModel.dateDetail)
            .disposed(by: disposeBag)
        
        viewModel.nextButtonEnable
            .drive(nextButton.rx.isEnabled)
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
    }
}

extension Details.ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let count = textField.text?.count ?? 0 + string.count
        if textField === titleTextField {
            return count < 15 || string == ""
        } else {
            return count < 20 || string == ""
        }
    }
}
