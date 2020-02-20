//
//  SettingUIViewController.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/19.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class MyCollectionView: UICollectionView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event) else { return nil }
        if hitView == self {
            return nil
        } else {
            return hitView
        }
    }
}

class SubscribeViewController: UIViewController {
    var likeKey: keyEnums!
    
    private lazy var userDefault = UserDefaultHelper(key: likeKey)
    private var keyboardHeight: CGFloat = 0
    private var userSubscribeArray: [String] {
        guard let array = userDefault.getSubscribe() else { return [""] }
        return array.map { $0.name }
    }
    
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
        let collectionView = MyCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = AssetsColor.babplusBackground.getColor()
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AssetsColor.babplusBackground.getColor()
        menuTextField.becomeFirstResponder()
        setupCollectionView()
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
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
        20
    }
    // 아이템 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let font = UIFont.systemFont(ofSize: 20, weight: .light)
        let textFieldAttr = [NSAttributedString.Key.font: font]
        return (userSubscribeArray[indexPath.item] as NSString).size(withAttributes: textFieldAttr)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard userSubscribeArray.count > indexPath.item else { return }
        let selectItem = userSubscribeArray[indexPath.item]
        userDefault.removeData(str: selectItem)
        self.view.endEditing(true)
        collectionView.reloadData()
    }
}

extension SubscribeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userSubscribeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubscribeCollectionCell.identifier, for: indexPath) as! SubscribeCollectionCell
        cell.configure(subscribeName: (userSubscribeArray[indexPath.row]))
        return cell
    }
}

extension SubscribeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return true }
        if text.count > 10 {
            Hong3Toast(ConstantsMessage.characterofLess).show(self, keyboardHeight: keyboardHeight)
            return false
        }
        guard !userDefault.isInData(string: text) else {
            Hong3Toast(ConstantsMessage.aleradyInItem).show(self, keyboardHeight: keyboardHeight)
            return false
        }
        guard userDefault.subscribeCnt() <= 10 else {
            Hong3Toast(ConstantsMessage.userDefaultOver).show(self, keyboardHeight: keyboardHeight)
            return false
        }
        userDefault.addData(string: text)
        collectionView.reloadData()
        textField.text = ""
        return true
    }
}

// MARK: ACTION
extension SubscribeViewController {
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: UI
extension SubscribeViewController {
    
    private func setupCollectionView() {
        collectionView.register(SubscribeCollectionCell.self, forCellWithReuseIdentifier: SubscribeCollectionCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
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
