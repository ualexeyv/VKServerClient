//
//  Photos.swift
//  VKClientServer
//
//  Created by пользовтель on 15.07.2021.
//

import Foundation
import DynamicJSON
import RealmSwift
/*
// MARK: - Welcome
struct Photos: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [PhotosModel]
   
}

// MARK: - Item
class PhotosModel: Object, Codable {
    @objc dynamic var albumID, date, id, ownerID: Int
    @objc dynamic var hasTags: Bool
    var sizes: [Size]
    @objc dynamic var text: String
//    let sizes = List<Size>()
//    var likes: Likes
//    var reposts: Reposts
//    @objc dynamic var realOffset: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case sizes, text//, likes, reposts
 //       case realOffset = "real_offset"
    }
    override static func primaryKey() -> String? {
            return "id"
    }
}

// MARK: - Likes
/*class Likes: Object, Codable {
    @objc dynamic var userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}*/

// MARK: - Reposts
/*class Reposts: Object, Codable {
    @objc dynamic var count: Int = 0
}*/

// MARK: - Size
class Size: Object, Codable {
    @objc dynamic var height: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var width: Int = 0
 
} */

class Photos2: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var sizes: String = ""
    @objc dynamic var ownerId: Int = 0
    convenience required init(json: JSON) {
        self.init()
        self.id = json.id.int ?? 0
        self.sizes = json.sizes[0].url.string ?? ""
        self.ownerId = json.owner_id.int ?? 0
    }
    override static func primaryKey() -> String? {
            return "id"
    }
    
}
/*class Sizes: Object {
    @objc dynamic var height: Int = 0
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var width: Int = 0
    convenience required init(json: JSON) {
        self.init()
        self.height = json.id.int ?? 0
        self.url = json.url.string ?? ""
        self.type = json.type.string ?? ""
        self.width = json.width.int ?? 0
    }
}*/
