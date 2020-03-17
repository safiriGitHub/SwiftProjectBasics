//
//  UIApplication+Extension.swift
//  ChildPediatric
//
//  Created by safiri on 2018/5/13.
//  Copyright © 2018年 safiri. All rights reserved.
//

import Foundation
import UIKit

public extension UIApplication {
    var appBuild: String {
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
}
