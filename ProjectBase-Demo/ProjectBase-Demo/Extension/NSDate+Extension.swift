//
//  NSDate+Extension.swift
//  ChildPediatric
//
//  Created by safiri on 2018/4/29.
//  Copyright © 2018年 safiri. All rights reserved.
//

import Foundation

let FormatYMDString = "yyyy-MM-dd"
let FormatYMDHMSString = "yyyy-MM-dd HH:mm:ss"
let FormatYMDHMSString2 = "yyyyMMddHHmmss"
let FormatYMDHMString = "yyyy-MM-dd HH:mm"
let FormatYMDChineseString = "yyyy年MM月dd日"
let FormatYMDHMChineseString = "yyyy年MM月dd日 HH:mm"

//有时间再扩展功能
public extension Date {
    
    static func timeNow(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date());
    }
    
    /**
     1970的时间戳转化为指定格式时间字符串 timeString为秒
    */
    static func timeTransform(timeStampInterval stamp: Double, forFormatString format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let date = Date(timeIntervalSince1970: stamp)
        let dateString = formatter.string(from: date);
        return dateString;
    }
    
    /**
     当前时间的1970时间戳
    */
    static func timeStampNow() -> Double {
        // *1000 是精确到毫秒，不乘就是精确到秒
        let timeStamp = Date().timeIntervalSince1970 * 1000
        return timeStamp
    }
    
    /**
     根据指定的日期字符串和格式，返回指定的日期格式的字符串
     
     @param giveDateString 指定的日期字符串
     @param formatString 指定的日期格式
     @param resultDateFormat 返回值指定的日期格式
     @return 返回值
     */
    
    static func timeTransition(fromGiveDate giveDateString: String?, formFormat formatString: String, resultFormat resultDateFormat: String) -> String {
        if giveDateString == nil {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        formatter.locale = Locale.current
        
        var resultDateString = ""
        if let giveDate = formatter.date(from: giveDateString!) {
            formatter.dateFormat = resultDateFormat
            resultDateString = formatter.string(from: giveDate)
        }
        return resultDateString
    }
    
    //MARK: Date modify
    /**
     Returns a date representing the receiver date shifted later by the provided number of days.
     
     @param days  Number of days to add.
     @return Date modified by the number of desired days.
     */
    func dateByAdding(_ days: Int) -> Date {
        let addTimeInterval = self.timeIntervalSinceReferenceDate + Double(86400 * days)
        let newDate = Date(timeIntervalSinceReferenceDate: addTimeInterval)
        return newDate
    }
    /**
    Returns a date representing the receiver date shifted later by the provided number of months.
    
    @param months  Number of months to add.
    @return Date modified by the number of desired months.
    */
    func dateByAddingMonths(_ months: Int) -> Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = months
        return calendar.date(byAdding: components, to: self)
    }
    
    //MARK: Date format
    /**
     Returns a formatted string representing this date.
     see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
     for format description.
     
     @param format   String representing the desired date format.
     e.g. @"yyyy-MM-dd HH:mm:ss"
     
     @return NSString representing the formatted date string.
     */
    func format(_ formatString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
    
    ///
//    static func timeTransform(fromTimeString from: String, forFormatString format: String) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = format
//        return ""
//    }
}

public extension DateFormatter {
    static func formatterShort() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }
        
}
