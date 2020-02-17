//
//  SettingModels.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/17.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import Foundation
import UIKit

struct Settings {
    let key: String
    let settingOptions: [SettingOptions]
}

struct SettingOptions {
    let settingName: String
    let identifier: String
    let indicator: Bool
    let nextVC: UIViewController?
    let toggleBtn: Bool
}

enum SettingType: String, CaseIterable {
    case babPlus = "밥+- 설정"
    case alarm = "알림설정"
    
    static let caseList = SettingType.allCases.map({ $0 })
    
    func getInfo() -> [SettingOptions] {
        switch self {
        case .babPlus:
            return [
                SettingOptions(
                    settingName: "좋아하는 음식 등록하기",
                    identifier: "favorite",
                    indicator: true,
                    nextVC: FavoriteViewController(),
                    toggleBtn: false
                ),
                SettingOptions(
                    settingName: "싫어하는 음식 등록하기",
                    identifier: "hate",
                    indicator: true,
                    nextVC: FavoriteViewController(),
                    toggleBtn: false
                )
            ]
        case .alarm:
            return [
                SettingOptions(
                    settingName: "길찾기",
                    identifier: "navigation",
                    indicator: false,
                    nextVC: nil,
                    toggleBtn: true
                ),
                SettingOptions(
                    settingName: "밥시간 알림",
                    identifier: "noti",
                    indicator: false,
                    nextVC: nil,
                    toggleBtn: true
                )
            ]
        default:
            return [SettingOptions(settingName: "nil", identifier: "nil", indicator: false, nextVC: nil, toggleBtn: false)]
        }
    }
    
}
