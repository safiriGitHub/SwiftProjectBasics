//
//  BaseTableVC.swift
//  ProjectBase
//
//  Created by safiri on 2018/5/7.
//  Copyright © 2018年 safiri. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SnapKit
import MJRefresh

open class BaseTableVC: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional  setup after loading the view.
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - tableView
    open func configTableViewIB(_ tableViewIB: UITableView) {
        tableViewIB.emptyDataSetSource = self
        tableViewIB.emptyDataSetDelegate = self
        tableViewIB.tableFooterView = UIView()
        if #available(iOS 11.0, *) {
            tableViewIB.contentInsetAdjustmentBehavior = .never
        }
        self.tableView = tableViewIB
    }
    
    open lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        return tableView
    }()
    
    open func snp_tableView() {
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(view.safeAreaInsets)
            } else {
                make.top.equalTo(topLayoutGuide.snp.top)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(bottomLayoutGuide.snp.bottom)
            }
        }
    }
    
    //MARK: - MJRefresh
    open var mjPage = 1

    open lazy var refreshHeader: AppRefreshHeader = {
        let header = AppRefreshHeader(refreshingBlock: { [weak self] in
            self!.mjPage = 1
            self!.getPageData(true)
        })
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel?.isHidden = true
        return header
    }()
    open lazy var refreshFooter: AppRefreshAutoGifFooter = {
        let footer = AppRefreshAutoGifFooter(refreshingBlock: { [weak self] in
            self!.mjPage += 1
            self!.getPageData(true)
        })
        footer.isAutomaticallyChangeAlpha = false
        return footer
    }()
    open lazy var refreshAutoNormalFooter: MJRefreshAutoNormalFooter = {
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self!.mjPage += 1
            self!.getPageData(true)
        })
        footer.isRefreshingTitleHidden = false

        return footer
    }()
    open func getPageData(_ isMjRefresh: Bool = false) { }

    open func refreshFirstPageData() {
        mjPage = 1
        getPageData()
    }
    open func mjHeaderBeginRefreshing() {
        tableView.mj_header?.beginRefreshing()
    }
    
    
    //MARK: - DZNEmptyData
    open struct DZNEmptyDataStruct {
        
        open var emptyImageName: String = ""
        open var emptyTitle = NSAttributedString(string: "")
        open var emptyDescription = NSAttributedString(string: "")
        open var emptyButtonTitle = NSAttributedString(string: "")
        /// 竖直方向调整位置
        open var emptyVerticalOffset: CGFloat = -60
        open var emptySpaceHeight: CGFloat = 11
        
        open init() { }
        
        open static func DZNEmptyTitle(_ title: String,
                                  color: UIColor = UIColor.lightGray/*目前用这个颜色，后期做常用颜色库*/,
            font: UIFont = UIFont.systemFont(ofSize: 16)) -> NSAttributedString {
            return NSAttributedString(string: title, attributes: [.foregroundColor : color, .font : font])
        }
        open static func DZNEmptyDescription(_ description: String,
                                        color: UIColor = UIColor.lightGray,
                                        font: UIFont = UIFont.systemFont(ofSize: 14, weight: .light)) -> NSAttributedString {
            return NSAttributedString(string: description, attributes: [.foregroundColor : color, .font : font])
        }
        open static func netLoadingModel() -> DZNEmptyDataStruct {
            var emptyData = DZNEmptyDataStruct()
            emptyData.emptyTitle = DZNEmptyTitle("正在努力加载...")
            return emptyData
        }
        open static func netFailedModel() -> DZNEmptyDataStruct {
            var emptyData = DZNEmptyDataStruct()
            emptyData.emptyTitle = DZNEmptyTitle("网络数据加载失败")
            emptyData.emptyDescription = DZNEmptyDescription("别紧张，试试看刷新页面")
            emptyData.emptyImageName = "none_message";
            return emptyData
        }
        open static func netSuccessForNoneData(title: String, imageName image: String, buttonTitle: String? = nil) -> DZNEmptyDataStruct {
            var emptyData = DZNEmptyDataStruct()
            emptyData.emptyTitle = DZNEmptyDataStruct.DZNEmptyTitle(title)
            emptyData.emptyImageName = image
            if let bt = buttonTitle {
                emptyData.emptyButtonTitle = DZNEmptyDataStruct.DZNEmptyTitle(bt)
            }
            return emptyData
        }
    }
    
    open var emptyDataSource:DZNEmptyDataStruct = DZNEmptyDataStruct()
    /// 根据指定的 DZNEmptyDataStruct 刷新 DZNEmptyControl
    open func refreshDZNEmptyControl(_ emptyData: DZNEmptyDataStruct) {
        emptyDataSource = emptyData
        self.tableView.reloadEmptyDataSet()
    }
    open func refreshEmptyNetLoading() {
        refreshDZNEmptyControl(DZNEmptyDataStruct.netLoadingModel())
    }
    open func refreshEmptyNetFailed() {
        refreshDZNEmptyControl(DZNEmptyDataStruct.netFailedModel())
    }
    open func refreshEmptyNetSuccessForNoneData(_ title: String, _ image: String) {
        refreshDZNEmptyControl(DZNEmptyDataStruct.netSuccessForNoneData(title: title, imageName: image))
    }
    
    
    
    open private func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: emptyDataSource.emptyImageName)
    }
    open private func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return emptyDataSource.emptyTitle
    }
    open private func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return emptyDataSource.emptyDescription
    }
    open private func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return emptyDataSource.emptyVerticalOffset
    }
    
    open private func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        return emptyDataSource.emptyButtonTitle
    }
    open private func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        getPageData()
    }
    open private func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        getPageData()
    }
    
}
