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
    let cellType: CellType
    let indicator: Bool
    let nextVC: UIViewController?
    let toggleBtn: Bool
    
}

enum CellType {
    case indicatorCell
    case switchCell
    case defaultCell
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
                    cellType: CellType.indicatorCell,
                    indicator: true,
                    nextVC: FavoriteViewController(),
                    toggleBtn: false
                ),
                SettingOptions(
                    settingName: "싫어하는 음식 등록하기",
                    identifier: "hate",
                    cellType: CellType.indicatorCell,
                    indicator: true,
                    nextVC: DislikeViewController(),
                    toggleBtn: false
                )
            ]
        case .alarm:
            return [
                SettingOptions(
                    settingName: "길찾기",
                    identifier: "navigation",
                    cellType: CellType.switchCell,
                    indicator: false,
                    nextVC: nil,
                    toggleBtn: true
                ),
                SettingOptions(
                    settingName: "밥시간 알림",
                    identifier: "noti",
                    cellType: CellType.switchCell,
                    indicator: false,
                    nextVC: nil,
                    toggleBtn: true
                )
            ]
        default:
            return [
                SettingOptions(
                    settingName: "nil",
                    identifier: "nil",
                    cellType: CellType.defaultCell,
                    indicator: false,
                    nextVC: nil,
                    toggleBtn: false
                )
            ]
        }
    }
    
}
