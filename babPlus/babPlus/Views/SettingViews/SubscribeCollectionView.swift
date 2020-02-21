//
//  SubscribeCollectionView.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/21.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class SubscribeCollectionView: UICollectionView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event) else { return nil }
        if hitView == self {
            return nil
        } else {
            return hitView
        }
    }
}
