//
//  Photos.swift
//  VKClientServer
//
//  Created by пользовтель on 15.07.2021.
//

import Foundation
import SwiftyJSON
import RealmSwift


/*class Photos2: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var sizes: String = ""
    @objc dynamic var ownerId: Int = 0
    convenience required init(json: JSON) {
        self.init()
        self.id = json["id"].int ?? 0
        self.sizes = json["sizes"][0]["url"].string ?? ""
        self.ownerId = json["owner_id"].int ?? 0
    }
    override static func primaryKey() -> String? {
            return "id"
    }
    
}*/

// MARK: - NewsRequst
struct PhotoRequest: Codable {
    let response: PhotoResponse
}

// MARK: - Response
struct PhotoResponse: Codable {
    let items: [Photos2]
   
}
// MARK: - Item
class Photos2: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var ownerId: Int
    var sizes: [Sizes]
 

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case ownerId = "owner_id"
        case sizes
 //       case comments, likes, reposts
    }
    override static func primaryKey() -> String? {
            return "id"
    }
    
}
class Sizes: Object, Codable {
    @objc dynamic var url: String
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}

