//
//  MainBranchCollectionViewCell.swift
//  babPlus
//
//  Created by YoujinMac on 2020/02/04.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

enum highlightSwitch: String {
    case babPlus      = "      밥 +        "
    case babMinus     = "      밥 -        "
    case babPlusMinus = "       밥 +-        "
    case nothing
}

class MainBranchCollectionViewCell: UICollectionViewCell {
    static let identifier = "MainBranchCell"
    private let branchImage = UIImageView()
    
    let branchName: UILabel = {
        let label = BabplusLabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    var highlightLabel: UILabel = {
        let label = UILabel()
        label.transform = .init(rotationAngle: .pi / 4)
        label.textColor = .white
        return label
    }()
    
    var cellWidth: CGFloat = 0
    var cellHeight: CGFloat = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = AssetsColor.babplusCellBackground.getColor()
        cellWidth = self.bounds.width
        cellHeight = self.bounds.height
        setupUI()
        setupConstraints()
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        //이미지 그림자
        contentView.backgroundColor = .clear
        
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 4
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.6
        
        branchImage.layer.cornerRadius = 8
        branchImage.layer.masksToBounds = true
        branchImage.contentMode = .scaleAspectFill
        
    }
    
    private func setupConstraints() {
        let labelHeight:CGFloat = 20
        [branchImage, branchName].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        
        NSLayoutConstraint.activate([
            branchImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            branchImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -labelHeight),
            branchImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            branchImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            branchName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            branchName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            branchName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            branchName.heightAnchor.constraint(equalToConstant: labelHeight),
        ])
        
    }
    
    func updateLabel(key: highlightSwitch) {
        guard key != .nothing else {
            highlightLabel.removeFromSuperview()
            return
        }
        var labelColor = UIColor.red
        switch key {
        case .babMinus:
            labelColor = .blue
        case .babPlusMinus:
            labelColor = .purple
        default:
            labelColor = .red
        }
        self.highlightLabel.text = key.rawValue
        self.highlightLabel.backgroundColor = labelColor
        contentView.addSubview(highlightLabel)
        highlightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highlightLabel.leadingAnchor.constraint(
                equalTo: contentView.centerXAnchor,
                constant: (cellWidth * 0.11)
            ),
            highlightLabel.bottomAnchor.constraint(
                equalTo: contentView.centerYAnchor,
                constant: -(cellHeight * 0.31)
            )
        ])
    }
    
    
    func configure(branchName name: String) {
        guard let cacheData = UserDefaultHelper(key: .imageKey).getImage() else { return }
        if let i = cacheData.first(where: { $0.name == name }) {
            branchName.text = i.name
            if i.imageData == nil {
                branchImage.image = UIImage(named: "logo")
            } else {
                branchImage.image = UIImage(data: i.imageData!)
            }
        }
        
    }
    
}
