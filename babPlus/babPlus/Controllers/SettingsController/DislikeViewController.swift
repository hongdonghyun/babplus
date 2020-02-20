//
//  DislikeViewController.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/18.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class DislikeViewController: SubscribeViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        super.likeKey = keyEnums.dislike
        menuTextField.placeholder = "싫어하는 음식을 입력하세요."
    }

}
