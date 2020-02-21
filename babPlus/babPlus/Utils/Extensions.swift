//
//  extensions.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/13.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

//MARK: - XOR
extension Bool {
    static func ^ (left: Bool, right: Bool) -> Bool {
        return left != right
    }
}

func textWidth(text: String, font: UIFont?) -> CGSize {
    let attributes = font != nil ? [NSAttributedString.Key.font: font] : [:]
    return text.size(withAttributes: attributes)
}
