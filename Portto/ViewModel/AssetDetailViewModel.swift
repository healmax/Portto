//
//  AssetDetailViewModel.swift
//  Portto
//
//  Created by Vincent on 2022/5/7.
//

import Foundation

final class AssetDetailViewModel {
    private let asset: Asset
    var imageUrl: URL? { URL(string: asset.imageUrl) }
    var name: String { asset.name }
    var collectionName: String { asset.collectionName }
    var description: String { asset.description }
    var permalinkURL: URL? { URL(string: asset.permalink) }
    
    init(asset: Asset) {
        self.asset = asset
    }
}
