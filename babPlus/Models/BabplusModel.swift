//
//  BabplusModel.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/17.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

// MARK: - BabMenu
struct BabMenu: Decodable {
    let date: String
    let contents: [Content]
}

// MARK: - Content
struct Content: Decodable {
    let name, lat, lon, tag: String
    let image: String?
    let address: String
    let menus: Menus
    
}

// MARK: - Menu
struct Menus: Decodable {
    let lunch, dinner: [String]
}

// MARK: - ContentImage
struct ContentImage: Codable {
    let name: String
    let imageData: Data?
}
