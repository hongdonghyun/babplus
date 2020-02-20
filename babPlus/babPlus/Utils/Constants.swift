//
//  constants.swift
//  babPlus
//
//  Created by YoujinMac on 2020/02/05.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import Foundation
import MapKit

struct Constants {
    static let mapCenterlat = 37.544792611423425//위도
    static let mapCenterlon = 127.05570731194194//경도
    static let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
    static let base_url = "https://1cr8sgkm6e.execute-api.ap-northeast-2.amazonaws.com/prod/"
    static let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
}

struct ConstantsMessage {
    static let characterofLess = "음식이름은\n 10자이하로 입력해주세요."
}


enum AssetsColor {
    case babplusBackground
    case babplusCellBackground
    case babplusTextColor
    case babplusTableCellTextColor
    case babplusSwitchOffColor
    case babplusUnderLineColor
    
    func getColor() -> UIColor {
        switch self {
        case .babplusBackground:
            return UIColor(named: "BabplusBackground")!
        case .babplusCellBackground:
            return UIColor(named: "BabplusCellBackground")!
        case .babplusTextColor:
            return UIColor(named: "BabplusTextColor")!
        case .babplusTableCellTextColor:
            return UIColor(named: "BabplusTableCellTextColor")!
        case .babplusSwitchOffColor:
            return UIColor(named: "BabplusSwitchOffColor")!
        case .babplusUnderLineColor:
            return UIColor(named: "BabplusUnderLineColor")!
        }
    }
}
