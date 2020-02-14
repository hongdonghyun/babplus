//
//  extensions.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/13.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import Foundation
import UIKit

enum AssetsColor {
    case babplusBackground
    case babplusCellBackground
    case babplusTextColor
    
    func getColor() -> UIColor {
        switch self {
        case .babplusBackground:
            return UIColor(named: "BabplusBackground")!
        case .babplusCellBackground:
            return UIColor(named: "BabplusCellBackground")!
        case .babplusTextColor:
            return UIColor(named: "BabplusTextColor")!
        }
    }
}

