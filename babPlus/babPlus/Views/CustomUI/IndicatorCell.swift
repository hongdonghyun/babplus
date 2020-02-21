//
//  IndicatorCell.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/18.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

final class IndicatorCell: SettingViewCustomCell {
    static let identifier = "indicatorCell"
    var nextVC: UIViewController?
    
    override func configure(settingOption setting: SettingOptions) {
        super.configure(settingOption: setting)
        accessoryType = .disclosureIndicator
        self.backgroundColor = AssetsColor.babplusCellBackground.getColor()
        self.tintColor = AssetsColor.babplusTextColor.getColor()
        self.nextVC = setting.nextVC
        

    }

}
