//
//  extensions.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/13.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import Foundation

//MARK: - XOR
extension Bool {
    static func ^ (left: Bool, right: Bool) -> Bool {
        return left != right
    }
}
