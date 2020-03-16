//
//  UITableView+Extension.swift
//  ChildPediatric
//
//  Created by safiri on 2018/4/21.
//  Copyright © 2018年 safiri. All rights reserved.
//

import Foundation
import UIKit

public protocol RegisterCellFromNib {
    static var height: CGFloat { get }
}

public extension RegisterCellFromNib {
    static var identifier: String { return "\(self)" }
    static var nib: UINib? { return UINib(nibName: "\(self)", bundle: nil) }
}

public extension UITableView {
    /// 注册 cell 的方法
    func zs_registerCell<T: UITableViewCell>(cell: T.Type) where T:RegisterCellFromNib {
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: T.identifier)
        }else {
            register(cell, forCellReuseIdentifier: T.identifier)
        }
    }
    
    ///从缓存池出队已经存在的 cell
    func zs_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
    func zs_dequeueReusableCell<T: UITableViewCell>() -> T where T: RegisterCellFromNib {
        return dequeueReusableCell(withIdentifier: T.identifier) as! T
    }
    func tableSectionHeaderViewForApp(_ headerTitle: String, _ headerHeight: CGFloat) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: headerHeight))
        view.backgroundColor = UIColor.white
        
        let lineViewV = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: headerHeight))
        lineViewV.backgroundColor = UIColor.appMainColor
        view.addSubview(lineViewV)
        
        let lable = UILabel(frame: CGRect(x: lineViewV.x + 15, y: 0, width: 200, height: headerHeight))
        lable.text = headerTitle
        lable.textColor = UIColor.appTextColor1
        lable.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(lable)
        
        let lineViewH = UIView(frame: CGRect(x: 0, y: 30-1, width: self.width, height: 1))
        lineViewH.backgroundColor = UIColor.appTextColor4
        view.addSubview(lineViewH)
        
        return view
    }
    /// 蓝底白字样式
    func tableSectionHeaderViewForAppStyle2(_ headerTitle: String?, _ headerHeight: CGFloat) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: headerHeight))
        view.backgroundColor = UIColor.appMainColor
        
        let lable = UILabel(frame: CGRect(x: 15, y: 0, width: self.width, height: headerHeight))
        lable.text = headerTitle
        lable.textColor = UIColor.white
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.adjustsFontSizeToFitWidth = true
        view.addSubview(lable)
        
        return view
    }
}
