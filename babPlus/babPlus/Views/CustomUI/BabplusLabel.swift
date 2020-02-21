//
//  babplusLabel.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/19.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class BabplusLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        textColor = AssetsColor.babplusTextColor.getColor()
    }
}
