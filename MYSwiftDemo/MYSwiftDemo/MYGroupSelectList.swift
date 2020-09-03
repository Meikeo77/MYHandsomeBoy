//
//  MYGroupSelectList.swift
//  MYSwiftDemo
//
//  Created by Meikeo on 2020/9/3.
//  Copyright © 2020 Meikeo. All rights reserved.
//

import UIKit

class MYGroupSelectList: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let cellIdentifier:String = "HomeListTableViewCell"
    public var groupModel : MYGroupModel!
    var tableView: UITableView!
    var progressView: MYProgressView!
    var groupList: [MYGroupModel]!
        
    init(groupModel: MYGroupModel) {
        super.init(nibName: nil, bundle: nil)
        self.groupModel = groupModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "通讯录"
        let rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(self.rightClick))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.progressView = MYProgressView(progress: self.groupModel.name)
        self.progressView.frame = CGRect(origin: CGPoint(x: 0, y: 64), size: CGSize(width: self.view.frame.size.width, height: 50))
        self.view.addSubview(self.progressView)
        
        self.tableView = UITableView.init(frame: CGRect(origin: CGPoint(x: 0, y: 114), size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height-50)), style: .plain)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.register(MYListTableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(self.tableView)
        
        self.groupList = self.groupModel.children
        
    }
    
    @objc func rightClick() -> Void {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell : MYListTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MYListTableViewCell
        
        let group : MYGroupModel = self.groupList[indexPath.row]
        
        customCell.cellType = listCellType.groupCellType
        customCell.fillViewWithValue(header: group.avatar, nameString: group.name, isBeenSelect: false)
        
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

