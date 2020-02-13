//
//  BabplusModel.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/05.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

// MARK: - BabMenu
struct BabMenu: Decodable {        
    let date: String
    let contents: [Content]
}

struct Content: Decodable {
    let name, lat, lon, tag: String
    let imageURL: String?
    let address: String
    let menus: Menus
    
}

// MARK: - Menu
struct Menus: Codable {
    let lunch, dinner: [String]
}

struct ContentImage {
    let name: String
    let image: UIImage?
}
