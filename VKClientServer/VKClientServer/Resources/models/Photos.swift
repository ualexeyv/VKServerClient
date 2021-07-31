//
//  Photos.swift
//  VKClientServer
//
//  Created by пользовтель on 15.07.2021.
//

import Foundation
import DynamicJSON
import RealmSwift
// MARK: - Welcome
struct Photos: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [PhotosModel]
    let more: Int
}

// MARK: - Item
class PhotosModel: Object, Codable {
    @objc dynamic var albumID, date, id, ownerID: Int
    @objc dynamic var hasTags: Bool
    var sizes: [Size]
    @objc dynamic var text: String
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
}

struct Photos2 {
    let id: Int
    let sizes: [Size2]
}
struct Size2 {
    let height: Int
    let url: String
    let type: String
    let width: Int
}
