//
//  GroupFB.swift
//  VKClientServer
//
//  Created by пользовтель on 30.07.2021.
//

import Foundation
import Firebase

class GroupsFB {
    let groupName: String
    let photo50: String
    let id: Int
    let ref: DatabaseReference?
    
    init(groupName: String, photo50: String, id: Int) {
        self.groupName = groupName
        self.id = id
        self.photo50 = photo50
        self.ref = nil
    }
    
    init? (snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String : Any],
              let groupName = value["groupName"] as? String,
              let photo50 = value["photo50"] as? String,
              let id = value["id"] as? Int else { return nil }
        self.ref = snapshot.ref
        self.groupName = groupName
        self.id = id
        self.photo50 = photo50
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "groupName": groupName,
            "id": id,
            "photo50": photo50
        ] as [String: Any]
    }
}
