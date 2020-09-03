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
    var groupModel : MYGroupModel!
    var progressString : String = ""
    var tableView: UITableView!
    var progressView: MYProgressView!
        
    init(groupModel: MYGroupModel , progress:String) {
        super.init(nibName: nil, bundle: nil)
        self.groupModel = groupModel
        if progress.count > 0 {
            self.progressString = progress + ">" + self.groupModel.name
        }else {
            self.progressString = self.groupModel.name
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "通讯录"
        let rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(self.rightClick))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.progressView = MYProgressView(progress: self.progressString)
        self.progressView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: 50))
        self.view.addSubview(self.progressView)
        
        self.tableView = UITableView.init(frame: CGRect(origin: CGPoint(x: 0, y: 50), size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height-50)), style: .plain)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.register(MYListTableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    @objc func rightClick() -> Void {
        //返回root并刷新
        self.navigationController?.popToRootViewController(animated: true)
        NotificationCenter.default.post(Notification(name: Notification.Name("selectComplete"), object: self, userInfo: nil))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.groupModel.children.count > 0 {
            return self.groupModel.children.count
        }else if self.groupModel.members.count > 0 {
            return self.groupModel.members.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell : MYListTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MYListTableViewCell
        
        if self.groupModel.children.count > 0 {
            let group : MYGroupModel = self.groupModel.children[indexPath.row]
            customCell.cellType = listCellType.groupCellType
            customCell.fillViewWithValue(header: group.avatar, nameString: group.name, isBeenSelect: group.isSelected)
            
            customCell.tapBlock = { isSelect in
                group.isSelected = isSelect
                //内部所有的选中都要取消
                self.cancelAllSelectInGroup(group: group)
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
            
        }else if self.groupModel.members.count > 0 {
            let member: MYMemberModel = self.groupModel.members[indexPath.row]
            customCell.cellType = listCellType.memberCellType
            customCell.fillViewWithValue(header: member.avatar, nameString: member.nickname, isBeenSelect: member.isSelected)
            
            customCell.tapBlock = { isSelect in
                member.isSelected = isSelect
                self.judgeAllItemsBeenSelect(group: self.groupModel)
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.groupModel.children.count > 0 {
            //跳转
            let group: MYGroupModel = self.groupModel.children[indexPath.row]
            let groupVC: MYGroupSelectList = MYGroupSelectList(groupModel: group, progress: self.progressString)
            self.navigationController?.pushViewController(groupVC, animated: true)
        }
    }
    
    ///取消内部全部选中
    func cancelAllSelectInGroup(group: MYGroupModel) -> Void {
        if group.children.count > 0 {
            for item in group.children {
                item.isSelected = false
                cancelAllSelectInGroup(group: item)
            }
        }else if group.members.count > 0 {
            for member in group.members {
                member.isSelected = false
            }
        }
    }
    
    func judgeAllItemsBeenSelect(group: MYGroupModel) -> Void {
        var selectNum: Int = 0
        if group.children.count > 0 {
            for item in group.children {
                if item.isSelected {
                    selectNum = selectNum + 1
                }
            }
            group.isSelected = group.children.count == selectNum ? true : false
            
            
        }else if group.members.count > 0 {
            for member in group.members {
                if member.isSelected {
                    selectNum = selectNum + 1
                }
            }
            group.isSelected = group.members.count == selectNum ? true : false
        }
    }
}

