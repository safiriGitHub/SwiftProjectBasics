//
//  LoadBundleUtil.swift
//  ProjectBase-Demo
//
//  Created by pengpai on 2020/3/9.
//  Copyright © 2020 safiri. All rights reserved.
//

import Foundation
import UIKit

open class LoadBundleUtil {
    
    
    public static func loadImage(bundle: String, imageName: String, _ imageType: String = "png") -> UIImage? {
        
        if let path = Bundle(for: self).path(forResource: bundle, ofType: "bundle"),
            let bundle = Bundle.init(path: path),
            let imagePath = bundle.path(forResource: imageName, ofType: "png") {
       
            return UIImage.init(contentsOfFile: imagePath)
        }
        return nil
    }
}
