//
//  ContentView.swift
//  MYHandsomeBoy
//
//  Created by Meikeo on 2020/9/1.
//  Copyright © 2020 Meikeo. All rights reserved.
//

import SwiftUI
import HandyJSON


var company : groupModel = getAddressBook()
private var listData : [cellModel] = [cellModel(name:company.name , avatar: "header", children: company.children!)]


func getAddressBook() -> groupModel {
    var group : groupModel = groupModel()
    let path = Bundle.main.path(forResource: "addressBook", ofType: "json")
    let url = URL(fileURLWithPath: path!)
    do {
        let data = try Data(contentsOf: url)
        let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        let jsonDic = jsonData as! NSDictionary
        let result : NSDictionary = jsonDic["result"] as! NSDictionary
        group = groupModel.deserialize(from: result)!
        
    } catch let error as Error? {
        print("读取本地数据出现错误!",error)
    }
    return group
}



struct ContentView: View {
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(named: "ListBackgroundColor")
        UITableViewCell.appearance().backgroundColor = UIColor(named: "CellBackgroundColor")
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorColor = UIColor(named: "ListBackgroundColor")
        UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        UITableViewCell.appearance().accessoryType = .none
    }
    
    var body: some View {
        NavigationView {
            List(listData) { (model:cellModel) in
                NavigationLink(model.name, destination:MemberListView(dataSource: model.children))
            }
        .navigationBarTitle(Text("首页"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
