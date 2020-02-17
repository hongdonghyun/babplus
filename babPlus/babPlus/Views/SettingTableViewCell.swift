//
//  SettingTableViewCell.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/14.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
}

class SettingTableViewCell: CustomCell {
    static let indetifier = "settingCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AssetsColor.babplusTextColor.getColor()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = AssetsColor.babplusCellBackground.getColor()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(settingOptions setting: SettingOptions) {
        guard (setting.indicator ^ setting.toggleBtn) else { return }
        titleLabel.text = setting.settingName
        
        if setting.indicator {
            accessoryType = .disclosureIndicator
            self.backgroundColor = AssetsColor.babplusCellBackground.getColor()
            self.tintColor = AssetsColor.babplusTextColor.getColor()
            self.selectionStyle = .none
            
        }
        
        if setting.toggleBtn {
            setupSwitch(identifier: setting.identifier)
        }
    }
    
    private func setupSwitch(identifier: String) {
        let `switch`: UISwitch = {
            let `switch` = UISwitch()
            `switch`.accessibilityIdentifier = identifier
            `switch`.onTintColor = AssetsColor.babplusSwitchOffColor.getColor()
            return `switch`
        }()
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        [`switch`].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            `switch`.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            `switch`.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            `switch`.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    
    private func setupUI() {
        let safeArea = contentView.safeAreaLayoutGuide
        
        [titleLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10)
        ])
    }
}
