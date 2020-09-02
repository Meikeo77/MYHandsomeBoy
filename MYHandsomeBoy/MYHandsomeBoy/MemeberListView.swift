//
//  MemeberListView.swift
//  MYHandsomeBoy
//
//  Created by Meikeo on 2020/9/2.
//  Copyright © 2020 Meikeo. All rights reserved.
//

import SwiftUI

struct MemeberListView: View {
    @State var memberArray: [MYMemberModel] = [MYMemberModel()]
    var progressText: String = ""
    
    var body: some View {
        VStack {
            progressView(title: progressText)
            ZStack {
                List(memberArray) { (memeber: MYMemberModel) in
                    commonRow(avatar: "header", name: memeber.nickname, isSelect: memeber.isSelected)
                    EmptyView()
                }
            }
        }
    }
}

struct MemeberListView_Previews: PreviewProvider {
    static var previews: some View {
        MemeberListView()
    }
}
