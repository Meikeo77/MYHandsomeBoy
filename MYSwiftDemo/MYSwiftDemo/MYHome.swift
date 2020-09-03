//
//  MYHome.swift
//  MYSwiftDemo
//
//  Created by Meikeo on 2020/9/3.
//  Copyright © 2020 Meikeo. All rights reserved.
//

import UIKit

class MYHome: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let cellIdentifier:String = "HomeListTableViewCell"
    
    var companyModel: MYGroupModel?
    var tableView: UITableView!
    var selectedList: [MYMemberModel]?
    
    func readAddressBook() -> MYGroupModel {
        var group : MYGroupModel = MYGroupModel()
        let path = Bundle.main.path(forResource: "addressBook", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            let jsonDic = jsonData as! NSDictionary
            let result : NSDictionary = jsonDic["result"] as! NSDictionary
            group = MYGroupModel.deserialize(from: result)!
            
        } catch let error as Error? {
            print("读取本地数据出现错误!",error?.localizedDescription as Any)
        }
        return group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
        self.navigationItem.title = "谁是最帅的人"
        let rightBarButtonItem = UIBarButtonItem(title: "开始选择", style: .plain, target: self, action: #selector(self.rightClick))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.tableView = UITableView.init(frame: self.view.frame, style: .plain)
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.register(MYListTableViewCell.classForCoder(), forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(tableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(selectCompleteAction), name: NSNotification.Name("selectComplete"), object: nil)
        
    }
    
    @objc func selectCompleteAction() {
        //取出所有的member
        self.selectedList = []
        self.getAllSelectMemebers(group: self.companyModel!)
        self.tableView.reloadData()
    }
    
    @objc func rightClick() {
        self.companyModel = readAddressBook()
        let selectVC : MYGroupSelectList = MYGroupSelectList(groupModel: self.companyModel!, progress: "")
        self.navigationController?.pushViewController(selectVC, animated: true)
    }
    
    func getAllSelectMemebers(group: MYGroupModel) {
        
        if group.children.count > 0 {
            for item in group.children {
                getAllSelectMemebers(group: item)
            }
        }else if group.members.count > 0 {
            for memeber in group.members {
                if memeber.isSelected {
                    self.selectedList?.append(memeber)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell : MYListTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MYListTableViewCell
        
        let memberModel : MYMemberModel = self.selectedList![indexPath.row]
        
        customCell.cellType = .homeCellType
        customCell.fillViewWithValue(header: memberModel.avatar, nameString: memberModel.nickname, isBeenSelect: false)
        
        customCell.selectionStyle = .none
        return customCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
