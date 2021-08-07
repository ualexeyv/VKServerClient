// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsRequst = try? newJSONDecoder().decode(NewsRequst.self, from: jsonData)

import Foundation
import DynamicJSON

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

class News2 {
    var text: String = ""
    var newsImage: String = ""
    var docImage: String = ""
    init (json: JSON) {
        self.text = json.text.string ?? ""
        self.newsImage = json.attachments[0].photo.sizes[0].url.string ?? ""
        self.docImage = json.attachments[0].doc.url.string ?? ""
    }
}

struct NewFeed: Codable {
    let response: NewsFeedResponse
}

// MARK: - Response
struct NewsFeedResponse: Codable {
    
    let items: [NewsFeedModel]
}

struct NewsFeedModel: Codable {
    
    var url: [String] = []
    var text: String = ""
    
    enum AttachmentType: String, Codable {
        case photo, video
    }
    
    private enum RootKeys: String, CodingKey {
        case text, attachments
    }
    private enum AttachmentsKeys: String, CodingKey {
        case photo, video
    }
    private enum PhotoKeys: String, CodingKey {
        case sizes
    }
    private enum SizesKeys: String, CodingKey {
        case url
    }
    private enum VideoKeys: String, CodingKey {
        case image
    }
    private enum ImageKeys: String, CodingKey {
        case url
    }
    init (from decoder: Decoder) throws {
        let topLevelContainer = try decoder.container(keyedBy: RootKeys.self)
        self.text = try topLevelContainer.decode(String.self, forKey: .text)
        var attachmentUnkeyedContainer = try topLevelContainer.nestedUnkeyedContainer(forKey: .attachments)
        var sizesArray = [String]()
        var urlArray = [String]()
        while !attachmentUnkeyedContainer.isAtEnd {
            let typeContainer = try attachmentUnkeyedContainer.nestedContainer(keyedBy: AnyCodingKeys.self)
            let type = try typeContainer.decode(String.self, forKey: "type")
            switch type {
            case "photo":
                let attachmentConteiner = try attachmentUnkeyedContainer.nestedContainer(keyedBy: AttachmentsKeys.self)
                let photoConteiner = try attachmentConteiner.nestedContainer(keyedBy: PhotoKeys.self, forKey: .photo)
                var sizesUnkeyedConteiner = try photoConteiner.nestedUnkeyedContainer(forKey: .sizes)
                while !sizesUnkeyedConteiner.isAtEnd {
                    let sizesContainer = try sizesUnkeyedConteiner.nestedContainer(keyedBy: SizesKeys.self)
                    sizesArray.append(try sizesContainer.decode(String.self, forKey: .url))
                }
            
                guard let url = sizesArray.first else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [PhotoKeys.sizes], debugDescription: "sizes cannot be empty"))}
                self.url.append(url)
 /*           case "video":
                let attachmentConteiner = try attachmentUnkeyedContainer.nestedContainer(keyedBy: AttachmentsKeys.self)
                let videoConteiner = try attachmentConteiner.nestedContainer(keyedBy: VideoKeys.self, forKey: .video)
                var imageUnkeyedContainer = try videoConteiner.nestedUnkeyedContainer(forKey: .image)
                while !imageUnkeyedContainer.isAtEnd {
                    let imageContainer = try imageUnkeyedContainer.nestedContainer(keyedBy: ImageKeys.self)
                    urlArray.append(try imageContainer.decode(String.self, forKey: .url))
                }
                guard let url = urlArray.first else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [PhotoKeys.sizes], debugDescription: "image cannot be empty"))}
                self.url.append(url) */
            default:
                fatalError()
            }
            }
            
        
    }
    
}
struct SafelyDecodedArray<T: Decodable>: Decodable {
    let result: [Result<T, Error>]
    init (from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        result = try container.safelyDecodeArray(T.self)
    }
}
private struct EmptyDecodable: Decodable {}

extension UnkeyedDecodingContainer {
    mutating func safelyDecodeArray<T: Decodable>(_ type: T.Type) throws -> [Result<T, Error>] {
        var result = [Result<T, Error>]()
        while !isAtEnd {
            do {
                let model = try decode(T.self)
                result.append(.success(model))
            } catch {
                result.append(.failure(error))
                _ = try? decode(EmptyDecodable.self)
            }
        }
        return result
    }
}
struct AnyCodingKeys: CodingKey {
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    
    init?(intValue: Int) {
        stringValue = String(intValue)
    }
 
}
extension AnyCodingKeys: ExpressibleByStringLiteral {
    init(stringLiteral value: StringLiteralType) {
        self.init(stringValue: value)!
    }
}
