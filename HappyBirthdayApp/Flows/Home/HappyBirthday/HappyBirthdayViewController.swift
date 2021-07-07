//
//  HappyBirthdayViewController.swift
//  HappyBirthdayApp
//
//  Created by Tal Ben Asuli MAC  on 06/07/2021.
//

import UIKit
import RxCocoa
import RxSwift

extension HappyBirthday {
    
    final class ViewController: UIViewController {
        
        private lazy var titleLabel = UILabel()
            .text(viewModel.title)
            .font(UIFont.App.header3.value)
            .numberOfLines(2)
            .textAlignment(.center)
            .textColor(UIColor.App.darkGreyBlue)
        
        private lazy var rightImageView = UIImageView()
            .image(named: viewModel.rightImageName)
        
        private lazy var leftImageView = UIImageView()
            .image(named: viewModel.leftImageName)
        
        private lazy var subtitleLabel = UILabel()
            .font(UIFont.App.header3.value)
            .numberOfLines(1)
            .textAlignment(.center)
            .textColor(UIColor.App.darkGreyBlue)
        
        private lazy var circleImageView = UIImageView()
            .borderWidth(7)
            .borderColor(style.circleBorderColor)
            .backgroundColor(style.circleBackgorundColor)
            .clipsToBounds(true)
        
        private lazy var bottomLogo = UIImageView()
            .image(named: viewModel.bottomImageName)
            .contentMode(.center)
        
        private lazy var button = UIButton()
            .title(viewModel.buttonTitle)
            .font(UIFont.App.text2.value)
            .image(UIImage(named: "icShareWhiteSmall"))
            .semanticContentAttribute(.forceRightToLeft)
            .showsTouchWhenHighlighted(true)
            .backgroundColor(UIColor.App.blush)
        
        private lazy var buttonOncircleImageView = UIButton()
            .image(UIImage(named: style.buttonOncircleImageViewImageName))
        
        private let centerImage = UIImageView()
        private let leftNumberImageView = UIImageView()
        private let backgroundImageView = UIImageView()

        private let viewModel: HappyBirthdayViewModelType
        private let disposeBag = DisposeBag()
        private let style: Style
        
        init(with viewModel: HappyBirthdayViewModelType, style: Style) {
            self.viewModel = viewModel
            self.style = style
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupNavigation()
            layoutViews()
            bindViewModel()
            applyStyle()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            circleImageView.layer.cornerRadius = circleImageView.frame.height / 2
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
}

private extension HappyBirthday.ViewController {
    
    func setupNavigation() {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrowBackBlue"),
                                         landscapeImagePhone: nil,
                                         style: .done,
                                         target: nil,
                                         action: nil)
        
        backButton.rx.tap
            .bind(to: viewModel.backTapped)
            .disposed(by: disposeBag)
        
        navigation(style: .background(color: .clear),
                   .separator(.clear),
                   .left(buttons: [backButton]))
    }
    
    func layoutViews() {
        view.add(titleLabel, leftNumberImageView, leftImageView, rightImageView, subtitleLabel, centerImage, backgroundImageView, bottomLogo, button, circleImageView, buttonOncircleImageView)
                        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(.veryHuge)
            make.trailing.equalToSuperview().inset(.veryHuge)
            make.topMargin.equalToSuperview().offset(.huge)
        }
        
        leftNumberImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(.small)
            make.centerX.equalToSuperview()
        }
        
        leftImageView.snp.makeConstraints { make in
            make.trailing.equalTo(leftNumberImageView.snp.leading).inset(-22)
            make.centerY.equalTo(leftNumberImageView)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.leading.equalTo(leftNumberImageView.snp.trailing).offset(.big)
            make.centerY.equalTo(leftNumberImageView)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(leftNumberImageView.snp.bottom).offset(.small)
        }
        
        circleImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(.medium)
            make.width.height.equalTo(250)
        }
        
        centerImage.snp.makeConstraints { make in
            make.center.equalTo(circleImageView)
        }
        
        bottomLogo.snp.makeConstraints { make in
            make.top.equalTo(circleImageView.snp.bottom).offset(.medium)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        button.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading).offset(.medium)
            make.trailing.equalTo(titleLabel.snp.trailing).inset(.medium)
            make.top.equalTo(bottomLogo.snp.bottom).offset(.medium)
        }
        
        buttonOncircleImageView.snp.makeConstraints { make in
            make.top.equalTo(circleImageView).offset(.small)
            make.trailing.equalTo(circleImageView).inset(.medium)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func applyStyle() {
        backgroundImageView.image = UIImage(named: style.backgroundName)
        view.backgroundColor = style.backgroundColor
        centerImage.image = UIImage(named: style.centerImageViewName)
        circleImageView.image = UIImage(named: style.centerImageViewName)
    }
    
    func bindViewModel() {
        
        viewModel.numberImageName
            .map { return UIImage(named: $0) }
            .bind(to: leftNumberImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.subtitle
            .bind(to: subtitleLabel.rx.text)
            .disposed(by: disposeBag)
        
        buttonOncircleImageView.rx.tap
            .bind(to: viewModel.buttonOnCirclTapped)
            .disposed(by: disposeBag)
        
        viewModel.selectedImage
            .bind(to: circleImageView.rx.image)
            .disposed(by: disposeBag)
    }
}

extension HappyBirthday.ViewController {
    
    enum Style: Int {
        case fox = 0
        case elephant = 1
        case pelican = 2
        
        var backgroundName: String {
            switch self {
            case .fox: return "iOsBgFox"
            case .elephant: return "iOsBgElephant"
            case .pelican: return "iOsBgPelican2"
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .fox: return UIColor.App.lightBlueGrey2
            case .elephant: return UIColor.App.pale
            case .pelican: return UIColor.App.lightBlueGrey
            }
        }
        
        var buttonOncircleImageViewImageName: String {
            switch self {
            case .fox: return "cameraIconGreen"
            case .elephant: return "cameraIconYellow"
            case .pelican: return "cameraIconBlue"
            }
        }
        
        var centerImageViewName: String {
            switch self {
            case .fox: return "defaultPlaceHolderGreen"
            case .elephant: return "defaultPlaceHolderYellow"
            case .pelican: return "defaultPlaceHolderBlue"
            }
        }
        
        var circleBorderColor: UIColor {
            switch self {
            case .fox: return UIColor.App.darkGreyBlue1
            case .elephant: return UIColor.App.pale1
            case .pelican: return UIColor.App.lightBlue
            }
        }
        
        var circleBackgorundColor: UIColor {
            switch self {
            case .fox: return UIColor.App.darkGreyBlue2
            case .elephant: return UIColor.App.pale2
            case .pelican: return UIColor.App.lightBlue2
            }
        }
    }
}
