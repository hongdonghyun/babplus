//
//  AppDelegate.swift
//  babPlus
//
//  Created by YoujinMac on 2020/02/03.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var dummy: BabMenu?
    var storeImage = [ContentImage]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let launchScreen = LaunchViewController()
        print("appdelegate")
        window?.rootViewController = launchScreen
        window?.makeKeyAndVisible()
        return true
    }

}

