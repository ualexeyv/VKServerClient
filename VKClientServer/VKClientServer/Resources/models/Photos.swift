//
//  Photos.swift
//  VKClientServer
//
//  Created by пользовтель on 15.07.2021.
//

import Foundation
import DynamicJSON

// MARK: - Welcome
struct Photos: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Item]
    let more: Int
}

// MARK: - Item
struct Item: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let sizes: [Size]
    let text: String
    let likes: Likes
    let reposts: Reposts
    let realOffset: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case sizes, text, likes, reposts
        case realOffset = "real_offset"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let url: String
    let type: String
    let width: Int
}
