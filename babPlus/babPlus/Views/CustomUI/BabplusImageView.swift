//
//  BabplusImageView.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/21.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class BabplusImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
