//
//  FavoriteViewController.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/14.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class FavoriteViewController: SubscribeViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        menuTextField.placeholder = "좋아하는 음식을 입력하세요."
    }
}
