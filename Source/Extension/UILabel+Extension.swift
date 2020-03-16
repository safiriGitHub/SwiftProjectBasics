//
//  UILabel+Extension.swift
//  ChildPediatric
//
//  Created by safiri on 2018/5/11.
//  Copyright © 2018年 safiri. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
    func setHtmlString(_ htmlStr: String) {
        if let data = htmlStr.data(using: String.Encoding.unicode) {
            self.attributedText = try? NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html], documentAttributes: nil)
            
        }
    }
}
