//
//  ToastMessage.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/19.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import Foundation
import UIKit

fileprivate var isShow: Bool = false
fileprivate var HQueue: [UILabel] = []

class Hong3Toast: UILabel {
    init(_ message: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.text = message
        self.textColor = .white
        self.textAlignment = .center
        self.layer.cornerRadius = 20
        self.numberOfLines = 0
        self.sizeToFit()
    }
    
    public func show(_ controller: UIViewController, second: Double = 5.0) {
        let showOriginX = controller.view.frame.midX - (self.frame.width / 2)
        let showOriginY = controller.view.frame.maxY - (self.frame.height) - (controller.tabBarController?.tabBar.frame.height ?? 0) - 10
        frame.origin = CGPoint(x: showOriginX, y: showOriginY)
        
        controller.view.addSubview(self)
        if !isShow {
            self.isHidden = false
            isShow = true
            HQueue.append(self)
            UIView.animate(
                withDuration: second,
                delay: 0.0,
                options: .curveEaseOut,
                animations: ({
                    self.alpha = 0
                }),
                completion: ({ [weak self] isCompleted in
                    isShow = false
                    self?.removeFromSuperview()
                })
            )
            
        } else {
            HQueue.forEach {
                self.isHidden = true
                self.layer.removeAllAnimations()
                $0.removeFromSuperview()
            }
            HQueue.removeAll()
            isShow = false
            show(controller, second: second)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func hong3Toast(controller: UIViewController, message: String, second: Double) {
    let toastLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        label.text = " " + message + " "
        label.textColor = .white
        label.layer.cornerRadius = 20
        label.sizeToFit()
        return label
    }()
    
    let showOriginX = controller.view.frame.midX - (toastLabel.frame.width / 2)
    let showOriginY = controller.view.frame.maxY - (toastLabel.frame.height) - 10 - (controller.tabBarController?.tabBar.frame.height ?? 0)
    
    toastLabel.frame.origin = CGPoint(x: showOriginX, y: showOriginY)
    controller.view.addSubview(toastLabel)
    
    UIView.animate(
        withDuration: second,
        delay: 0.1,
        options: .curveEaseOut,
        animations: ({
            toastLabel.alpha = 0
        }),
        completion: ({ (isCompleted) in
            toastLabel.removeFromSuperview()
        })
    )
    
}

