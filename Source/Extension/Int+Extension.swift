//
//  Int+Extension.swift
//  LogisticsDriver
//
//  Created by pengpai on 2019/12/4.
//  Copyright © 2019 qiluys. All rights reserved.
//

import Foundation

//待整理 https://www.jianshu.com/p/b254759ccb15
public extension Int {
    /*这是一个内置函数
     lower : 内置为 0，可根据自己要获取的随机数进行修改。
     upper : 内置为 UInt32.max 的最大值，这里防止转化越界，造成的崩溃。
     返回的结果： [lower,upper) 之间的半开半闭区间的数。
     */
    static func randomIntNumber(lower: Int = 0,upper: Int = Int(UInt32.max)) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower)))
    }
    /**
     生成某个区间的随机数
     */
    static func randomIntNumber(range: Range<Int>) -> Int {
        return randomIntNumber(lower: range.lowerBound, upper: range.upperBound)
    }
    
    static func randomString(lower: Int = 0,upper: Int = Int(UInt32.max)) -> String {
        let r = lower + Int(arc4random_uniform(UInt32(upper - lower)))
        return String(r)
    }
    static func randomString(range: Range<Int>) -> String {
        let r = randomIntNumber(lower: range.lowerBound, upper: range.upperBound)
        return String(r)
    }
}
