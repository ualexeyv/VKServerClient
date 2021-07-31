//
//  user.swift
//  VKClientServer
//
//  Created by пользовтель on 31.07.2021.
//

import Foundation
import RealmSwift
import DynamicJSON

class UserModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var photo_50: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    convenience required init(json: JSON) {
        self.init()
        self.id = json.id.int ?? 0
        self.photo_50 = json.photo_50.string ?? ""
        self.firstName = json.first_name.string ?? ""
        self.lastName = json.last_name.string ?? ""
    }
    override static func primaryKey() -> String? {
            return "id"
    }
    
}
