//
//  AppMJRefreshView.swift
//  ChildPediatric
//
//  Created by safiri on 2018/4/22.
//  Copyright © 2018年 safiri. All rights reserved.
//

import UIKit
import MJRefresh

open class AppRefreshHeader: MJRefreshGifHeader {
    
    ///初始化
    open override func prepare() {
        super.prepare()
        
        var images = [UIImage]()
        for index in 0..<16 {
            if let image = LoadBundleUtil.loadImage(bundle: "AppRefresh", imageName: "dropdown_loading_\(index/10)\(index%10)@2x")?.withRenderingMode(.alwaysOriginal) {
                images.append(image)
            }
        }
        // 设置空闲状态的图片
        setImages(images, for: .idle)
        // 设置刷新状态的图片
        setImages(images, for: .refreshing)
        setTitle("刷新数据", for: .idle)
        setTitle("开始加载", for: .pulling)
        setTitle("刷新中", for: .refreshing)
        stateLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    
    open override func placeSubviews() {
        super.placeSubviews()
        //这里设置图片和文字的位置
        /*1 图片上文字下
        gifView?.contentMode = .center
        gifView?.frame = CGRect(x: 0, y: 4, width: mj_w, height: 25)
        stateLabel?.font = UIFont.systemFont(ofSize: 12)
        stateLabel?.frame = CGRect(x: 0, y: 35, width: mj_w, height: 14)
         */
    }
}

open class AppRefreshAutoGifFooter: MJRefreshAutoGifFooter {
    
    /// 初始化
    open override func prepare() {
        super.prepare()
        // 设置控件的高度
        mj_h = 50
        // 图片数组
        var images = [UIImage]()
        // 遍历
        for index in 0..<8 {
           
            if let image = LoadBundleUtil.loadImage(bundle: "AppRefresh", imageName: "sendloading_18x18_\(index)@2x")?.withRenderingMode(.alwaysOriginal) {
                images.append(image)
            }
        }
        // 设置空闲状态的图片
        setImages(images, for: .idle)
        // 设置刷新状态的图片
        setImages(images, for: .refreshing)
        setTitle("上拉加载数据", for: .idle)
        setTitle("正在努力加载", for: .pulling)
        setTitle("正在努力加载", for: .refreshing)
        setTitle("没有更多数据啦", for: .noMoreData)
        stateLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    
    open override func placeSubviews() {
        super.placeSubviews()
        if let f = gifView?.frame,
            let c = gifView?.center {
            
            var tempFrame = f
            tempFrame.origin.x = 135
            gifView?.frame = tempFrame
            
            var tempCenter = c
            tempCenter.y = stateLabel?.center.y ?? 0
            gifView?.center = tempCenter
        }
        
    }
    
}

