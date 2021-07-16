//
//  Friends.swift
//  VKClientServer
//
//  Created by пользовтель on 13.07.2021.
//

import Foundation
import RealmSwift
// MARK: - Welcome
struct Friends: Codable {
    let response: FriendResponse
}

// MARK: - Response
struct FriendResponse: Codable {
    
    let items: [FriendsModel]
}

// MARK: - Item
class FriendsModel: Object, Codable {
    @objc dynamic var firstName: String
    @objc dynamic var id: Int
    @objc dynamic var lastName: String
    @objc dynamic var photo50: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        
    }
}
