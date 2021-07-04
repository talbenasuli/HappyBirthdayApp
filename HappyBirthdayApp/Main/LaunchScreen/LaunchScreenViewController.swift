//
//  LaunchScreenViewController.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 07/03/2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum Launch { }

extension Launch {
    final class ViewController: UIViewController {
        
        let titleLabel = UILabel()
            .text("Welcome")
            .font(UIFont.App.header1.value)
            .textAlignment(.center)
            .numberOfLines(0)
        
        private let _onFinished = PublishRelay<Void>()
        lazy var onFinished = _onFinished.asDriver(onErrorDriveWith: .never())
        
        let disposeBag = DisposeBag()

        private let duration: TimeInterval = 1.5
     
        init() {
            super.init(nibName: nil, bundle: nil)
            layoutViews()
            view.backgroundColor = .white
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            navigation(style: .none)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
                self?._onFinished.accept(())
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

private extension Launch.ViewController {
    
    func layoutViews() {
        view.add(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(.huge)
            make.trailing.equalToSuperview().inset(.huge)
        }
    }
}
