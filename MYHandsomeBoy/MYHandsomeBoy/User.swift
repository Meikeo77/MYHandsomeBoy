//
//  File.swift
//  MYHandsomeBoy
//
//  Created by MiaoYe on 2020/8/30.
//  Copyright © 2020 Meikeo. All rights reserved.
//

import Foundation
import HandyJSON

class memberModel: HandyJSON {
    var id: String = ""
    var weworkUserId: String = ""
    var nickName: String = ""
    var avatar: String = ""
    var phone: String = ""
    
    required init() {}
}

class groupModel: HandyJSON {
    var id: String!
    var name: String!
    var parentIds: NSArray?
    var hasSubGroup: Bool!
    var parentIdsString: NSArray?
    var members: [memberModel]?
    var children: [groupModel]?
    
    required init() {}
}


