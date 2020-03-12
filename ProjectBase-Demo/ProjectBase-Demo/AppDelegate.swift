//
//  AppDelegate.swift
//  ProjectBase-Demo
//
//  Created by pengpai on 2020/3/6.
//  Copyright © 2020 safiri. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let vc = ViewController()
        vc.title = "dd"
        //vc.tabBarItem.image = UIImage(named: imageName)
        //vc.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        vc.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        let navVC = UINavigationController(rootViewController: vc)
        
        
        window?.rootViewController = navVC
        
        return true
    }



}

