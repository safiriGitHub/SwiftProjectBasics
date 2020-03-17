//
//  UIView+Snapkit.swift
//  LogisticsCargoOwner
//
//  Created by pengpai on 2020/1/20.
//  Copyright © 2020 qiluys. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    func addHorizontallyAverageWidthViews(_ views: [UIView], height: CGFloat, leadingTrailing: CGFloat = 0, space: CGFloat = 0) {
        
        let count = views.count
        for i in 0..<count {
            addSubview(views[i])
            views[i].snp_makeConstraints { (make) in
                if i == 0 {
                    make.leading.equalToSuperview().offset(leadingTrailing)
                }else {
                    make.left.equalTo(self.subviews[i-1].snp_right).offset(space)
                    make.width.equalTo(self.subviews[i-1].snp_width)
                }
                if i == count-1 {
                    make.trailing.equalToSuperview().offset(-leadingTrailing)
                }
                make.centerY.equalToSuperview()
                make.height.equalTo(height)
            }
        }
    }
}
