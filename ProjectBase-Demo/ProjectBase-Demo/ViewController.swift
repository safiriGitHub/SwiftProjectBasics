//
//  ViewController.swift
//  ProjectBase-Demo
//
//  Created by pengpai on 2020/3/6.
//  Copyright © 2020 safiri. All rights reserved.
//

import UIKit

class ViewController: BaseTableVC, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        
    }

    func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.mj_header = refreshHeader
        tableView.mj_footer = refreshFooter
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        snp_tableView()
    }
    
    //MARK: UITableViewDataSource UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = "123"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func getPageData(_ isMjRefresh: Bool = false) {
        print(isMjRefresh)
    }
}

