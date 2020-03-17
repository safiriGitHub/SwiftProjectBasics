//
//  UIViewController+Extension.swift
//  ChildPediatric
//
//  Created by safiri on 2018/4/15.
//  Copyright © 2018年 safiri. All rights reserved.
//

import UIKit

public protocol StoryboardLoadable {}

public extension StoryboardLoadable where Self: UIViewController {
    static func loadFromMainStoryboard() -> Self {
        return loadFromStoryboard("Main")
    }
    static func loadFromStoryboard(_ sbName: String) -> Self {
        return UIStoryboard(name: sbName, bundle: nil).instantiateViewController(withIdentifier: "\(self)") as! Self
    }
}

public protocol NibLoadable {}

public extension NibLoadable {
    static func loadViewFromNib() -> Self {
        return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self
    }
}


public extension UIViewController {
    
    //MARK: - waiting cover view
    
    func showCoverUI() {
        let coverView = UIView()
        coverView.tag = 1001
        coverView.backgroundColor = UIColor.appTextColor5
        view.addSubview(coverView)
        coverView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    func hideCoverUI() {
        let v = view.viewWithTag(1001)
        UIView.animate(withDuration: 0.4, animations: {
            v?.alpha = 0
        }) { (_) in
            v?.removeFromSuperview()
        }
    }
     
     
    
    //MARK: - 页面跳转控制
    func pushViewController(_ vc: UIViewController) {
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    func popToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    /// 截取给定VC之前的页面(不包括给定VC) 页面栈控制
    func navigationViewControllersSubToVcClass(_ toVc: UIViewController) -> [UIViewController]? {
        if let vcArray = navigationController?.viewControllers {
            var presentVCs: [UIViewController] = []
            for vc in vcArray {
                if vc == toVc {
                    break;
                }else {
                    presentVCs.append(vc)
                }
            }
            return presentVCs
        }
        return nil
    }
    /// 截取给定VC之前的页面(不包括给定VC) 页面栈控制 用这个
    func navigationViewControllersSubToVcClass(presentVCs: inout [UIViewController], _ toVc: UIViewController) {
        if let vcArray = navigationController?.viewControllers {
            
            for vc in vcArray {
                if vc == toVc {
                    break;
                }else {
                    presentVCs.append(vc)
                }
            }
        }
    }
    func navigationViewControllersSubToVcClass(presentVCs: inout [UIViewController], _ endIndex: Int) {
          if let vcArray = navigationController?.viewControllers {
              for i in 0..<vcArray.count {
                  if i == endIndex {
                      break
                  }else {
                      presentVCs.append(vcArray[i])
                  }
              }
              
          }
      }
      
      ///push进入vc页面，
      func pushVCSkipSelf(_ vc: UIViewController) {
          vc.hidesBottomBarWhenPushed = true
          var presentVCs = [UIViewController]()
          self.navigationViewControllersSubToVcClass(presentVCs: &presentVCs, self)
          presentVCs.append(vc)
          self.navigationController?.setViewControllers(presentVCs, animated: true)
      }
    
    
    //MARK: - Navigation Config
    
    func customSystemBackItem(withImage imgName: String) {
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: imgName)
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: imgName)
        self.navigationItem.backBarButtonItem = backItem
    }
    ///配置导航栏和状态栏的属性
    func configNavigationAppearance(barColor: UIColor, titleTextAttributes dic: Dictionary<NSAttributedString.Key, Any>) {
        
        navigationController?.navigationBar.barTintColor = barColor
        navigationController?.navigationBar.titleTextAttributes = dic
        
        navigationController?.navigationBar.isTranslucent = false
        tabBarController?.tabBar.isTranslucent = false
    }
    
    /// 去除导航栏下方的横线
    func clearNavBarBottomLine() {
        if let t = self.navigationController?.navigationBar.isTranslucent, !t {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setRightBarButtonItemWithImage(_ imageName: String) {
        let img = UIImage(named: imageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let rightItem = UIBarButtonItem(image: img, style: UIBarButtonItem.Style.done, target: self, action: #selector(rightBarButtonItemClick))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    func setRightBarButtonItemWithString(_ string: String) {
        var width = 45
        if string.count == 4 {
            width = 70
        }else if (string.count > 4) {
            width = 80
        }
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        button.setTitle(string, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(rightBarButtonItemClick), for: .touchUpInside)
        
        let rightButtonItem = UIBarButtonItem(customView: button)
        rightButtonItem.style = .done
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -10
        self.navigationItem.rightBarButtonItems = [negativeSpacer,rightButtonItem]
    }
    
    func setWebViewNavBar() {
        if #available(iOS 11.0, *) {
            let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            fixedSpace.width = 15.0
            
            let leftBtn = UIButton(type: .custom)
            leftBtn.setImage(UIImage(named: "webNav_backItem"), for: .normal)
            leftBtn.addTarget(self, action: #selector(backWard), for: .touchUpInside)
            let leftItem = UIBarButtonItem(customView: leftBtn)
            
            let popBtn = UIButton(type: .custom)
            popBtn.setImage(UIImage(named: "webNav_closeItem"), for: .normal)
            popBtn.addTarget(self, action: #selector(popBackWard), for: .touchUpInside)
            let popItem = UIBarButtonItem(customView: popBtn)
            
            navigationItem.leftBarButtonItems = [leftItem,fixedSpace,popItem]
        }else {
            let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            fixedSpace.width = -17.0
            let fixedSpace1 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            fixedSpace1.width = 4.0
            
            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
            toolBar.clipsToBounds = true
            toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
            toolBar.setShadowImage(UIImage(), forToolbarPosition: .any)
            
            let leftItem = UIBarButtonItem(image: UIImage(named: "webNav_backItem"), style: .plain, target: self, action: #selector(backWard))
            let popItem = UIBarButtonItem(image: UIImage(named: "webNav_closeItem"), style: .plain, target: self, action: #selector(popBackWard))
            toolBar.items = [fixedSpace,leftItem,fixedSpace1,popItem,fixedSpace]
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: toolBar)
        }
    }
    
    
    @objc func backWard(){}
    @objc func popBackWard(){}
    @objc func rightBarButtonItemClick(){}
    
    //MARK: - alert
    
    func alert(title: String?, message: String?, style: UIAlertController.Style = .alert, alertActionTitles: [String], alertActionStyles: [UIAlertAction.Style], handler: ((Int) -> Void)? = nil, completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for i in 0..<alertActionTitles.count {
            alert.addAction(UIAlertAction(title: alertActionTitles[i], style: alertActionStyles[i], handler: { (_) in
                handler?(i)
            }))
        }
        self.present(alert, animated: true, completion: completion)
    }
}

