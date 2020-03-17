//
//  UIColor+Extension.swift
//  LogisticsDriver
//
//  Created by pengpai on 2019/12/3.
//  Copyright © 2019 qiluys. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    class var randomColor: UIColor {
        get {
            let color: UIColor = UIColor.init(red: (((CGFloat)((arc4random() % 256)) / 255.0)), green: (((CGFloat)((arc4random() % 256)) / 255.0)), blue: (((CGFloat)((arc4random() % 256)) / 255.0)), alpha: 1.0);
            return color
        }
    }
    
}

public extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat = 1.0) {
        if #available(iOS 10.0, *) {
            self.init(displayP3Red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
        } else {
            // Fallback on earlier versions
            self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
        }
    }
    
    convenience init(hexString:String){
        //处理数值
        var cString = hexString.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let length = (cString as NSString).length
        //错误处理
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){
            //返回whiteColor
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            return
        }
        
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        
        //字符chuan截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        //存储转换后的数值
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
    ///APP字体颜色 标题 333945
    static var appTextColor1: UIColor {
        get {
            return UIColor.init(r: 51, g: 57, b: 69)
        }
    }
    
    ///APP字体颜色 正文 5B6469
    static var appTextColor2: UIColor {
        get {
            return UIColor.init(r: 91, g: 100, b: 105)
        }
    }
    
    ///APP字体颜色 注释 9B9FAA
    static var appTextColor3: UIColor {
        get {
            return UIColor.init(r: 155, g: 159, b: 170)
        }
    }
    
    ///APP字体颜色 分隔线 E8E8E8
    static var appTextColor4: UIColor {
        get {
            return UIColor.init(r: 232, g: 232, b: 232)
        }
    }
    
    ///APP字体颜色 背景色 F5F6F7
    static var appTextColor5: UIColor {
        get {
            return UIColor.init(r: 245, g: 246, b: 247)
        }
    }
    
    ///APP主颜色 3795F9
    static  var appMainColor: UIColor {
        get {
            return UIColor(hexString: "5e2adc")
            
        }
    }
    
    ///APP设计红 FE292B
    static var appDesignRedColor: UIColor {
        get {
            return UIColor.init(r: 254, g: 41, b: 43)
        }
    }
    
    ///APP设计橘黄 FF853C
    static var appDesignOrangeColor: UIColor {
        get {
            return UIColor.init(r: 255, g: 133, b: 60)
        }
    }
    
    ///APP设计黄 FFD80E
    static var appDesignYellowColor: UIColor {
        get {
            return UIColor.init(r: 255, g: 216, b: 14)
        }
    }
    
    ///APP设计绿 3CCC75
    static var appDesignGreenColor: UIColor {
        get {
            return UIColor.init(r: 60, g: 204, b: 117)
        }
    }
    
    // for fLogisticsDriver
    static var appDesignButtonColor: UIColor {
        get {
            return UIColor(hexString: "5755D3")
        }
    }
}
