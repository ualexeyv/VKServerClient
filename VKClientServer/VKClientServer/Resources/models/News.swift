// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsRequst = try? newJSONDecoder().decode(NewsRequst.self, from: jsonData)

import Foundation

// MARK: - NewsRequst
struct NewsRequst: Codable {
    let response: NewsResponse
}

// MARK: - Response
struct NewsResponse: Codable {
    let newsItems: [NewsItem]
}

// MARK: - Item
struct NewsItem: Codable {
    let id: Int
    let text: String
    let copyHistory: [CopyHistory]
    let comments: Comments
    let likes: Likes
    let reposts: Reposts

    enum CodingKeys: String, CodingKey {
        case id
        case text
        case copyHistory = "copy_history"
        case comments, likes, reposts
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}

// MARK: - CopyHistory
struct CopyHistory: Codable {
    let attachments: [Attachment]

    enum CodingKeys: String, CodingKey {
        case attachments
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let photo: NewsPhoto
}

// MARK: - Photo
struct NewsPhoto: Codable {
    let sizes: [NewsSize]

    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

// MARK: - Size
struct NewsSize: Codable {
    let height: Int
    let url: String
    let width: Int
}

// MARK: - Likes
struct Likes: Codable {
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int

    enum CodingKeys: String, CodingKey {
        case count
    }
}

