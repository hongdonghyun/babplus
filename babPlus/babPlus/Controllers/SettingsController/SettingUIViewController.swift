//
//  SettingUIViewController.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/19.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class SubscribeViewController: UIViewController {
    
    private let userSubscribeArray = ["탕수육과짬뽕", "마늘", "짜장면아하항러ㅏ어랑ㄹ", "ㄴㅇ러ㅏㅣ파래", "오징어"]
    
    lazy var menuTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 25, weight: .medium)
        textField.delegate = self
        return textField
    }()
    
    private let underLine: UIView = {
        let view = UIView()
        view.backgroundColor = AssetsColor.babplusUnderLineColor.getColor()
        return view
    }()
    
    private let contentView = UIView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = AssetsColor.babplusBackground.getColor()
        return collectionView
    }()
    
    private func setupCollectionView() {
        collectionView.register(SubscribeCollectionCell.self, forCellWithReuseIdentifier: SubscribeCollectionCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AssetsColor.babplusBackground.getColor()
        menuTextField.becomeFirstResponder()
        setupCollectionView()
        setupUI()
    }
    
}

extension SubscribeViewController: UICollectionViewDelegateFlowLayout {
    // 상하좌우
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    // 위아래
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    // 아이템 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    // 아이템 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let font = UIFont.systemFont(ofSize: 20, weight: .light)
        let textFieldAttr = [NSAttributedString.Key.font: font]
        return (userSubscribeArray[indexPath.item] as NSString).size(withAttributes: textFieldAttr)
    }
}

extension SubscribeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userSubscribeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubscribeCollectionCell.identifier, for: indexPath) as! SubscribeCollectionCell
        cell.configure(subscribeName: userSubscribeArray[indexPath.row])
        return cell
    }
}

extension SubscribeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return true }
        if text.count > 10 {
            Hong3Toast(ConstantsMessage.characterofLess).show(self, second: 5.0)
        }
        textField.text = ""
        return true
    }
}

extension SubscribeViewController {
    private func setupUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        [contentView, menuTextField, underLine, collectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 100),
            
            collectionView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            menuTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            menuTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            menuTextField.heightAnchor.constraint(equalToConstant: 40),
            
            underLine.topAnchor.constraint(equalTo: menuTextField.bottomAnchor, constant: 5),
            underLine.centerXAnchor.constraint(equalTo: menuTextField.centerXAnchor),
            underLine.widthAnchor.constraint(equalTo: menuTextField.widthAnchor, multiplier: 1),
            underLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
