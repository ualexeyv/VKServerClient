//
//  Groups.swift
//  VKClientServer
//
//  Created by пользовтель on 14.07.2021.
//

import Foundation
import RealmSwift

class GroupsModel: Object  {
    @objc dynamic var id: Int = 0
    @objc dynamic var photo50: String = ""
    @objc dynamic var groupName: String = ""
    
    
    
    convenience required init(json: [String: Any]) {
        self.init()
        self.id = json["id"] as! Int
        self.photo50 = json["photo_50"] as! String
        self.groupName = json["name"] as! String
    }
    override static func primaryKey() -> String? {
            return "id"
    }
}
