//
//  usersFB.swift
//  VKClientServer
//
//  Created by пользовтель on 31.07.2021.
//

import Foundation
import Firebase

class UsersFB {
    let firstName: String
    let lastName: String
    let id: Int
    let ref: DatabaseReference?
    
    init(firstName: String, lastName: String, id: Int) {
        self.firstName = firstName
        self.id = id
        self.lastName = lastName
        self.ref = nil
    }
    init? (snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
            let firstName = value["firstName"] as? String,
            let lastName = value["lastName"] as? String,
            let id = value["id"] as? Int else {return nil}
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        self.ref = snapshot.ref
    }
    func toAnyObject() -> [String: Any] {
        return [
            "firstName": firstName,
            "id": id,
            "lastName": lastName
        ] as [String: Any]
    }
}
