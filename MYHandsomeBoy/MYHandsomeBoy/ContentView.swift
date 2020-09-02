//
//  ContentView.swift
//  MYHandsomeBoy
//
//  Created by Meikeo on 2020/9/1.
//  Copyright © 2020 Meikeo. All rights reserved.
//

import SwiftUI
import HandyJSON

struct commonRow : View {
    let avatar: String
    let name: String
    @State var isSelect: Bool
    var body: some View {
        return VStack {
            HStack {
                Image(avatar)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .cornerRadius(20)
                Text(name)
                    .font(.headline)
                    .fontWeight(.heavy)
                Spacer()
            }
            .frame(height: 55, alignment: .leading)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct progressView: View {
    let title: String
    var body: some View {
        return HStack {
            Text(title)
                .foregroundColor(.gray)
                .frame(height:30, alignment: .leading)
                .offset(x: 25)
            Spacer()
        }.background(Color.gray.opacity(0.3))
    }
}

struct sureButton: View {
    var canEdit: Bool
    var body: some View  {
        return Button(action: {}){
            Text("确定")
                .foregroundColor(Color.blue)
                .font(Font.caption)
        }
    }
}


func getAddressBook() -> MYGroupModel {
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


var company : MYGroupModel = getAddressBook()
var childrenList: [MYGroupModel] = company.children!

struct ContentView: View {
    @State var groupItem : MYGroupModel = MYGroupModel()
    
    var body: some View {
        return NavigationView {
            VStack {
                progressView(title: company.name)
                               
                List(childrenList) { (group: MYGroupModel) in
                    ZStack {
                        HStack{
                            commonRow(avatar: "header", name: group.name, isSelect: group.isSelected)
                            Spacer()
                            Button(action: {
                                group.isSelected.toggle()
                            }) {
                                Image(group.isSelected ? "select" : "select_un")
                                    .resizable()
                                    .renderingMode(.original)
                                    .frame(width:20, height: 20)
                            }
                        }
                        
                        if group.children?.count ?? 0 > 0 {
                            NavigationLink(destination: GroupListView(groupModel: group, progressText: company.name)) {
                                EmptyView()
                            }
                        }else {
                            NavigationLink(destination:MemeberListView(memberArray: group.members!, progressText: company.name + "->" + group.name)) {
                                EmptyView()
                            }
                        }
                    }
                }
                .navigationBarTitle("通讯录", displayMode: .inline)
                .navigationBarItems(trailing: sureButton(canEdit: true))
                .listStyle(PlainListStyle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
