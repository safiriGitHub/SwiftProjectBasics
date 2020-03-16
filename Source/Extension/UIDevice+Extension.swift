//
//  UIDevice+Extension.swift
//  LogisticsDriver
//
//  Created by pengpai on 2019/12/6.
//  Copyright © 2019 qiluys. All rights reserved.
//

import Foundation
import UIKit

public extension UIDevice {
    static func iPhone44S() -> Bool {
        return CGSize(width: 640, height: 960) == UIScreen.main.currentMode?.size
    }
    
    static func iPhone55S5C5E() -> Bool {
        return CGSize(width: 640, height: 1136) == UIScreen.main.currentMode?.size
    }
    
    static func iPhone66S78() -> Bool {
        return CGSize(width: 750, height: 1334) == UIScreen.main.currentMode?.size
    }
    
    static func iPhone6P6SP7P8P() -> Bool {
        return CGSize(width: 1242, height: 2208) == UIScreen.main.currentMode?.size
    }
    
    static func iPhoneXXS() -> Bool {
        return CGSize(width: 1125, height: 2436) == UIScreen.main.currentMode?.size
    }
    
    static func iPhoneXR() -> Bool {
        return CGSize(width: 828, height: 1792) == UIScreen.main.currentMode?.size
    }
    
    static func iPhoneXSMax() -> Bool {
        return CGSize(width: 1242, height: 2688) == UIScreen.main.currentMode?.size
    }
    
    static func iPhoneXSeries() -> Bool {
        return iPhoneXR() || iPhoneXXS() || iPhoneXSMax()
    }
}
