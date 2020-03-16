//
//  UIView+Extension.swift
//  ChildPediatric
//
//  Created by safiri on 2018/4/15.
//  Copyright © 2018年 safiri. All rights reserved.
//

import UIKit

public extension UIView {
    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var tempFrame = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return frame.origin.y
            
        }
        set {
            var tempFrame = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var tempFrame = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var tempFrame = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            var tempFrame = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            var tempCenter = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    ///centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            var tempCenter = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
    
    /** 给View画虚线边框
     
     */
    func drawImaginaryLine(lineColor: UIColor, lineWidth: Float = 1.0) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        shapeLayer.position = CGPoint(x: self.width/2, y: self.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        // 设置虚线颜色为blackColor [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = CGFloat(lineWidth)
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [NSNumber(value: 1),NSNumber(value: 1),]
        
//        let path = CGMutablePath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: self.bounds.width, y: 0))
//        path.addLine(to: CGPoint(x: self.bounds.width, y: self.frame.height))
//        path.addLine(to: CGPoint(x: 0, y: self.bounds.height))
//        path.addLine(to: CGPoint(x: 0, y: 0))
//        shapeLayer.path = path
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 2).cgPath
        self.layer.addSublayer(shapeLayer)
    }
    
    //MARK: load from nib
    
    static func loadNibNamed(_ nibName: String = "\(String(describing: self))", bundle: Bundle = Bundle.main) -> UINib {
        return UINib.init(nibName: nibName, bundle: bundle)
    }
    
    static func loadViewFromNib(bundle: Bundle = Bundle.main) -> Self {
        return bundle.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self
        
    }
}

public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue > 0 ? newValue : 0
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
}
