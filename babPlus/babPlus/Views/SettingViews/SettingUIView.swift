//
//  SettingUIView.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/18.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class SettingUIView: UIView {
    let menuTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 25, weight: .medium)
        return textField
    }()
    
    let underLine: UIView = {
        let view = UIView()
        view.backgroundColor = AssetsColor.babplusUnderLineColor.getColor()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let safeArea = self.safeAreaLayoutGuide
        
        [menuTextField, underLine].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            menuTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40),
            menuTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            menuTextField.heightAnchor.constraint(equalToConstant: 40),
            
            underLine.topAnchor.constraint(equalTo: menuTextField.bottomAnchor, constant: 5),
            underLine.centerXAnchor.constraint(equalTo: menuTextField.centerXAnchor),
            underLine.widthAnchor.constraint(equalTo: menuTextField.widthAnchor, multiplier: 1),
            underLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
