//
//  MyModel.swift
//  MYSwiftDemo
//
//  Created by Meikeo on 2020/9/3.
//  Copyright © 2020 Meikeo. All rights reserved.
//

import Foundation
import HandyJSON

class MYMemberModel: HandyJSON {
    var id: String!
    var weworkUserId: String!
    var nickname: String!
    var avatar: String!
    var phone: String!
    var isSelected : Bool = false
    required init() {}
}

class MYGroupModel: HandyJSON {
    var id: String!
    var name: String!
    var avatar: String = "header"
    var parentIds: NSArray?
    var hasSubGroup: Bool!
    var members: [MYMemberModel] = []
    var children: [MYGroupModel] = []
    var isSelected: Bool = false
    
    required init() {}
}

