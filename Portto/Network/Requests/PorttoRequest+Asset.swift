//
//  Portto+Request.swift
//  Portto
//
//  Created by Vincent on 2022/5/5.
//

import Moya

extension PorttoRequest {
    enum Assets {
        static let address = "0x19818f44faf5a217f619aff0fd487cb2a55cca65"
        static let subpath: String = "assets"
        
        struct FetchAssets : PorttoRequestDecodableType {
            typealias ResponseType = AssetList
            var path: String { Assets.subpath }
            var method: Method { .get }
            var task: Task { .requestParameters(parameters: parameters, encoding: URLEncoding.default) }
            public var sampleData: Data { AssetList.mockData }
            
            var parameters: [String : Any] {
                return [
                    "owner" : PorttoRequest.Assets.address,
                    "limit" : limit,
                    "offset" : offset,
                    "format" : "json"
                ]
            }
            
            private let limit: Int
            private let offset: Int
            
            init(limit: Int, offset: Int) {
                self.limit = limit
                self.offset = offset
            }
        }
    }
}


