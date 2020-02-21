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
        window?.rootViewController = launchScreen
        window?.makeKeyAndVisible()
        return true
    }

}

extension AppDelegate {
    func changeRootViewController(){
        let mainVC = MainViewController()
        let mapVC = BranchsAddressMapViewController()
        let settingVC = SettingViewController()
        let mainNaviController = UINavigationController(rootViewController: mainVC)
        let mapNaviController = UINavigationController(rootViewController: mapVC)
        let settingNaviController = UINavigationController(rootViewController: settingVC)
        
        mapNaviController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map.fill"), tag: 0)
        mainNaviController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        settingNaviController.tabBarItem = UITabBarItem(title: "설정", image: UIImage(named: "MoreIcon"), tag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mapNaviController, mainNaviController, settingNaviController]
        tabBarController.selectedIndex = 1
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
}
