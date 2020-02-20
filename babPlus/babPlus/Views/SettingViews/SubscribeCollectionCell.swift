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
        let label = babplusLabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        
        setupUI()
        
    }
    
    func configure(subscribeName name: String) {
        subscribeNameLabel.text = name
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
