//
//  SwitchCell.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/18.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import Foundation
import UIKit

final class SwitchCell: SettingViewCustomCell {
    static let identifier = "switchCell"
    let `switch`: UISwitch = {
        let `switch` = UISwitch()
        `switch`.onTintColor = AssetsColor.babplusSwitchOffColor.getColor()
        return `switch`
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSwitchUI()
    }
    
    private func setupSwitchUI() {
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
    
    override func configure(settingOption setting: SettingOptions) {
        super.configure(settingOption: setting)
        `switch`.accessibilityIdentifier = setting.identifier
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
