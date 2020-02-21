//
//  SubscribeCollectionCell.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/19.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class SubscribeCollectionCell: UICollectionViewCell {
    static let identifier = "SubscribeCell"
    
    private let subscribeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        self.layer.cornerRadius = 5
        setupUI()
        
    }
    
    func configure(subscribeName name: String) {
        let currentFont = self.subscribeNameLabel.font!
        let text = " " + name + " "
        subscribeNameLabel.text = text
        self.frame.size = (text as NSString).size(withAttributes: [NSAttributedString.Key.font : currentFont])

    }
    
    private func setupUI() {
        [subscribeNameLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            subscribeNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            subscribeNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
