//
//  UserDefaultModels.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/20.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import Foundation

// MARK: - ContentImage
struct ContentImage: Codable {
    let name: String
    let imageData: Data?
}

struct SubscribeModels: Codable {
    let name: String
}
