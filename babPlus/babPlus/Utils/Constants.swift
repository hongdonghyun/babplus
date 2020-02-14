//
//  constants.swift
//  babPlus
//
//  Created by YoujinMac on 2020/02/05.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import Foundation
import MapKit

struct Constants{
    static let mapCenterlat = 37.544792611423425//위도
    static let mapCenterlon = 127.05570731194194//경도
    static let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    static let base_url = "https://1cr8sgkm6e.execute-api.ap-northeast-2.amazonaws.com/prod/"
    static let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
}
