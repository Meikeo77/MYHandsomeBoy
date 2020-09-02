//
//  File.swift
//  MYHandsomeBoy
//
//  Created by MiaoYe on 2020/8/30.
//  Copyright © 2020 Meikeo. All rights reserved.
//

import Foundation
import HandyJSON
import Combine

class MYMemberModel: HandyJSON, Identifiable {
    var id: UUID = UUID()
    var weworkUserId: String = ""
    var nickname: String = ""
    var avatar: String = ""
    var phone: String = ""
    var isSelected : Bool = false
    required init() {}
}

class MYGroupModel: HandyJSON, Identifiable {
    var id: UUID = UUID()
    var name: String!
    var parentIds: NSArray?
    var hasSubGroup: Bool!
    var parentIdsString: NSArray?
    var members: [MYMemberModel]?
    var children: [MYGroupModel]?
    var isSelected: Bool = false
    
    required init() {}
}

final class selectedList : ObservableObject {
   
}

