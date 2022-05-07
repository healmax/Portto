//
//  Asset.swift
//  Portto
//
//  Created by Vincent on 2022/5/5.
//

import Foundation

struct AssetList: Decodable {
    var assets: [Asset]
    
    enum CodingKeys: String, CodingKey {
        case assets
    }
}

struct Asset: Decodable {
    
    struct Collection: Decodable {
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case name
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case name
        case collection
        case description
        case permalink
    }
    
    
    //收藏品圖片
    var imageUrl: String
    //收藏品名稱
    var name: String
    //collection.name
    var collectionName: String { collection?.name ?? "" }
    //收藏品描述
    var description: String
    //按鈕連結
    var permalink: String
    private var collection: Collection?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl).unwrapped(or: "")
        self.name = try container.decodeIfPresent(String.self, forKey: .name).unwrapped(or: "")
        self.description = try container.decodeIfPresent(String.self, forKey: .description).unwrapped(or: "")
        self.permalink = try container.decodeIfPresent(String.self, forKey: .permalink).unwrapped(or: "")
        self.collection = try container.decodeIfPresent(Collection.self, forKey: .collection)
    }
}

