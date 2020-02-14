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
}

extension UIColor {
//    static var backColor: UIColor {
//        UIColor(named: "BabplusBackground")
//    }
    static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
        case .babplusBackground:
            return UIColor(named: "BabplusBackground")!
        case .babplusCellBackground:
            return UIColor(named: "BabplusCellBackground")!
        case .babplusTextColor:
            return UIColor(named: "BabplusTextColor")!
        }
    }
    
}
