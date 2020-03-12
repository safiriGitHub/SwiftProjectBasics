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

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional  setup after loading the view.
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - tableView
    func configTableViewIB(_ tableViewIB: UITableView) {
        tableViewIB.emptyDataSetSource = self
        tableViewIB.emptyDataSetDelegate = self
        tableViewIB.tableFooterView = UIView()
        if #available(iOS 11.0, *) {
            tableViewIB.contentInsetAdjustmentBehavior = .never
        }
        self.tableView = tableViewIB
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        return tableView
    }()
    
    func snp_tableView() {
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
    var mjPage = 1

    lazy var refreshHeader: AppRefreshHeader = {
        let header = AppRefreshHeader(refreshingBlock: { [weak self] in
            self!.mjPage = 1
            self!.getPageData(true)
        })
        header.isAutomaticallyChangeAlpha = true
        header.lastUpdatedTimeLabel?.isHidden = true
        return header
    }()
    lazy var refreshFooter: AppRefreshAutoGifFooter = {
        let footer = AppRefreshAutoGifFooter(refreshingBlock: { [weak self] in
            self!.mjPage += 1
            self!.getPageData(true)
        })
        footer.isAutomaticallyChangeAlpha = false
        return footer
    }()
    lazy var refreshAutoNormalFooter: MJRefreshAutoNormalFooter = {
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: { [weak self] in
            self!.mjPage += 1
            self!.getPageData(true)
        })
        footer.isRefreshingTitleHidden = false

        return footer
    }()
    func getPageData(_ isMjRefresh: Bool = false) { }

    func refreshFirstPageData() {
        mjPage = 1
        getPageData()
    }
    func mjHeaderBeginRefreshing() {
        tableView.mj_header?.beginRefreshing()
    }
    
    
    //MARK: - DZNEmptyData
    struct DZNEmptyDataStruct {
        
        var emptyImageName: String = ""
        var emptyTitle = NSAttributedString(string: "")
        var emptyDescription = NSAttributedString(string: "")
        var emptyButtonTitle = NSAttributedString(string: "")
        /// 竖直方向调整位置
        var emptyVerticalOffset: CGFloat = -60
        var emptySpaceHeight: CGFloat = 11
        
        init() { }
        
        static func DZNEmptyTitle(_ title: String,
                                  color: UIColor = UIColor.lightGray/*目前用这个颜色，后期做常用颜色库*/,
            font: UIFont = UIFont.systemFont(ofSize: 16)) -> NSAttributedString {
            return NSAttributedString(string: title, attributes: [.foregroundColor : color, .font : font])
        }
        static func DZNEmptyDescription(_ description: String,
                                        color: UIColor = UIColor.lightGray,
                                        font: UIFont = UIFont.systemFont(ofSize: 14, weight: .light)) -> NSAttributedString {
            return NSAttributedString(string: description, attributes: [.foregroundColor : color, .font : font])
        }
        static func netLoadingModel() -> DZNEmptyDataStruct {
            var emptyData = DZNEmptyDataStruct()
            emptyData.emptyTitle = DZNEmptyTitle("正在努力加载...")
            return emptyData
        }
        static func netFailedModel() -> DZNEmptyDataStruct {
            var emptyData = DZNEmptyDataStruct()
            emptyData.emptyTitle = DZNEmptyTitle("网络数据加载失败")
            emptyData.emptyDescription = DZNEmptyDescription("别紧张，试试看刷新页面")
            emptyData.emptyImageName = "none_message";
            return emptyData
        }
        static func netSuccessForNoneData(title: String, imageName image: String, buttonTitle: String? = nil) -> DZNEmptyDataStruct {
            var emptyData = DZNEmptyDataStruct()
            emptyData.emptyTitle = DZNEmptyDataStruct.DZNEmptyTitle(title)
            emptyData.emptyImageName = image
            if let bt = buttonTitle {
                emptyData.emptyButtonTitle = DZNEmptyDataStruct.DZNEmptyTitle(bt)
            }
            return emptyData
        }
    }
    
    var emptyDataSource:DZNEmptyDataStruct = DZNEmptyDataStruct()
    /// 根据指定的 DZNEmptyDataStruct 刷新 DZNEmptyControl
    func refreshDZNEmptyControl(_ emptyData: DZNEmptyDataStruct) {
        emptyDataSource = emptyData
        self.tableView.reloadEmptyDataSet()
    }
    func refreshEmptyNetLoading() {
        refreshDZNEmptyControl(DZNEmptyDataStruct.netLoadingModel())
    }
    func refreshEmptyNetFailed() {
        refreshDZNEmptyControl(DZNEmptyDataStruct.netFailedModel())
    }
    func refreshEmptyNetSuccessForNoneData(_ title: String, _ image: String) {
        refreshDZNEmptyControl(DZNEmptyDataStruct.netSuccessForNoneData(title: title, imageName: image))
    }
    
    
    
    private func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: emptyDataSource.emptyImageName)
    }
    private func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return emptyDataSource.emptyTitle
    }
    private func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return emptyDataSource.emptyDescription
    }
    private func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return emptyDataSource.emptyVerticalOffset
    }
    
    private func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        return emptyDataSource.emptyButtonTitle
    }
    private func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        getPageData()
    }
    private func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        getPageData()
    }
    
}
