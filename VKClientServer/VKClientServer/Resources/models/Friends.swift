//
//  Friends.swift
//  VKClientServer
//
//  Created by пользовтель on 13.07.2021.
//

import Foundation

// MARK: - Welcome
struct Friends: Codable {
    let response: FriendResponse
}

// MARK: - Response
struct FriendResponse: Codable {
    
    let items: [User]
}

// MARK: - Item
struct User: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let photo50: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        
    }
}
