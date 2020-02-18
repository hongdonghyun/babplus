//
//  DislikeViewController.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/18.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class DislikeViewController: UIViewController {
    let contentView: UIView = {
        let view = SettingUIView()
        view.menuTextField.placeholder = "싫어하는 음식을 입력하세요."
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AssetsColor.babplusBackground.getColor()
        setupUI()
    }
    
}

extension DislikeViewController {
    private func setupUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        [contentView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}
