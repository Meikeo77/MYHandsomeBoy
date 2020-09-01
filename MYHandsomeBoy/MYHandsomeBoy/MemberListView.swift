//
//  MemberListView.swift
//  MYHandsomeBoy
//
//  Created by MiaoYe on 2020/8/31.
//  Copyright © 2020 Meikeo. All rights reserved.
//

import Foundation
import SwiftUI


struct cellModel: Identifiable {
    let id: UUID = UUID()
    let name: String
    let avatar: String
    let children: [groupModel]
}

struct commonRow : View {
    var model: cellModel
    var body: some View {
        return VStack {
            HStack {
                Image(model.avatar)
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(model.name)
                    .font(.headline)
                    .fontWeight(.heavy)
                Spacer()
                Image("arrow")
            }
            .frame(height: 55, alignment: .leading)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MemberListView: View {
    @State var dataSource: [groupModel] = [groupModel()]
    
    var body: some View {
        Text("123123")
//        NavigationView {
//            List(listData) { row in
//                commonRow(cellModel: row)
//            }
//            .navigationBarTitle(Text("次页"))
//        }
    }
}

struct MemberListView_Previews: PreviewProvider {
    static var previews: some View {
        MemberListView()
    }
}
