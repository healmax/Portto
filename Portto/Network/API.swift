//
//  API.swift
//  Portto
//
//  Created by Vincent on 2022/5/5.
//

import Moya
import RxSwift
import Alamofire

final class API {
    
    static let shared = API.init(provider: API.provider)
    static let moackShared = API.init(provider: API.mockProvider)
    
    fileprivate let provider: MoyaProvider<MultiTarget>
    
    private static let provider: MoyaProvider<MultiTarget> = {
        let configuration = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLoggerPlugin = NetworkLoggerPlugin(configuration: configuration)
        return MoyaProvider<MultiTarget>(plugins: [networkLoggerPlugin])
    }()
    
    private static let mockProvider: MoyaProvider<MultiTarget> = {
        return MoyaProvider<MultiTarget>(stubClosure: MoyaProvider.immediatelyStub)
    }()
    
    private init(provider: MoyaProvider<MultiTarget>) {
        self.provider = provider
    }
}

// MARK: - Rx extension
extension API: ReactiveCompatible {}

extension Reactive where Base == API {

    func request<Request: TargetType & DecodableResponse>(_ request: Request) -> Observable<Request.ResponseType> {
        let target = MultiTarget.init(request)
        return base.provider.rx.request(target)
            .asObservable()
            .filterSuccessfulStatusCodes()
            .map(Request.ResponseType.self)
    }
    
    
    func request<Request: TargetType>(_ request: Request, failsOnEmptyData: Bool = false) -> Observable<Any> {
        let target = MultiTarget.init(request)
        return base.provider.rx.request(target)
            .asObservable()
            .filterSuccessfulStatusCodes()
            .mapJSON(failsOnEmptyData: failsOnEmptyData)
    }
    
}
