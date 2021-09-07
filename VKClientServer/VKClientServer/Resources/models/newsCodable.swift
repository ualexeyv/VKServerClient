//
//  newsCodable.swift
//  VKClientServer
//
//  Created by пользовтель on 06.08.2021.
//

import Foundation

struct Feed: Decodable {
    let items: [FeedItem]
    enum ItemsKeys: String, CodingKey {
        case items
    }
    enum AttachmentKeys: String, CodingKey {
        case attachments, text
    }
    enum PhotoKeys: String, CodingKey {
        case photo, sizes
    }
    enum SizesKeys: String, CodingKey {
        case url
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ItemsKeys.self)
        var itemsContainer = try container.nestedUnkeyedContainer(forKey: .items)
        var itemsContainerCopy = itemsContainer
        var items: [FeedItem] = []
        var text: [String] = []
        while !itemsContainer.isAtEnd {
            let attachmentsContainer = try itemsContainer.nestedContainer(keyedBy: AttachmentKeys.self)
            text.append(try attachmentsContainer.decode(String.self, forKey: .text))
            var attachments = try attachmentsContainer.nestedUnkeyedContainer(forKey: .attachments)
            while !attachments.isAtEnd {
                let typeContainer = try attachments.nestedContainer(keyedBy: AnyCodingKeys.self)
                let type = try typeContainer.decode(String.self, forKey: "type")
                switch type {
                case "photo":
                    let photoContainer = try attachments.nestedContainer(keyedBy: PhotoKeys.self)
                    let photo = try photoContainer.nestedContainer(keyedBy: PhotoKeys.self, forKey: .photo)
                    var sizesContainer = try photo.nestedUnkeyedContainer(forKey: .sizes)
                    while !sizesContainer.isAtEnd {
                        let urlContainer = try sizesContainer.nestedContainer(keyedBy: SizesKeys.self)
                        let url = try urlContainer.decode(String.self, forKey: .url)
                    }
                default: fatalError()
                }
            
            }
        }
        self.items = items
    }
}
struct FeedItem: Decodable {
    let text: String
    let url: String
    
}

/*struct AnyCodingKeys: CodingKey {
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
    
    
}*/
