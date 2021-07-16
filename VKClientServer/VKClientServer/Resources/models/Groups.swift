//
//  Groups.swift
//  VKClientServer
//
//  Created by пользовтель on 14.07.2021.
//

import Foundation

struct Groups {
    var id: Int = 0
    var photo50: String = ""
    var groupName: String = ""
    
    init(json: [String: Any]) {
        self.id = json["id"] as! Int
        self.photo50 = json["photo_50"] as! String
        self.groupName = json["name"] as! String
    }
}
