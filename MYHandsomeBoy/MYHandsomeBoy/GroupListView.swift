//
//  GroupListView.swift
//  MYHandsomeBoy
//
//  Created by Meikeo on 2020/9/2.
//  Copyright © 2020 Meikeo. All rights reserved.
//

import SwiftUI



struct GroupListView: View {
    var groupModel: MYGroupModel! = MYGroupModel()
    var progressText: String = ""
    
    var body: some View {
        VStack {
            progressView(title: progressText + "->" + groupModel.name)
            List(groupModel.children!) { (group: MYGroupModel) in
                ZStack {
                    commonRow(avatar: "header", name: group.name, isSelect:group.isSelected)
                    NavigationLink(destination: MemeberListView(memberArray: group.members!, progressText:(self.progressText + "->" + self.groupModel.name + "->" + group.name))) {
                        EmptyView()
                    }
                }
            }
        }
    }
}

struct GroupListView_Previews: PreviewProvider {
    static var previews: some View {
        GroupListView()
    }
}
