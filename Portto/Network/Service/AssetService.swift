//
//  AssetService.swift
//  Portto
//
//  Created by Vincent on 2022/5/6.
//

import Foundation
import RxSwift

struct AssetService {
    private let apiService: API
    private let disposeBag = DisposeBag()

    public init(apiService: API = API.shared) {
        self.apiService = apiService
    }
    
    func fetchAssets(limit: Int, offset: Int) -> Observable<AssetList> {
        let target = PorttoRequest.Assets.FetchAssets.init(limit: limit, offset: offset)
        return apiService.rx.request(target)
    }
}
