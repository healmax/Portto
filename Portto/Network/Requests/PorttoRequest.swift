//
//  PorttoRequest.swift
//  Portto
//
//  Created by Vincent on 2022/5/5.
//

import Moya

struct PorttoRequest {}

protocol PorttoRequestType: TargetType {
    var parameters: [String: Any] { get }
}

extension PorttoRequestType {
    var baseURL: URL {
        return URL(string: "https://api.opensea.io/api/v1/")!
    }

    var headers: [String: String]? { ["X-API-KEY" : "5b294e9193d240e39eefc5e6e551ce83"] }
    var sampleData: Data { Data() }
    var parameters: [String: Any] { [:] }
}

protocol DecodableResponse {
    associatedtype ResponseType: Decodable
    var jsonDecodingEntryPath: String? { get }
}

extension DecodableResponse {
    // default to no json entry point
    var jsonDecodingEntryPath: String? { return nil }
}

protocol PorttoRequestDecodableType: PorttoRequestType & DecodableResponse {}
