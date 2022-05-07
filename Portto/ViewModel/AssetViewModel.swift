//
//  HomeViewModel.swift
//  Portto
//
//  Created by Vincent on 2022/5/5.
//

import Foundation
import RxSwift
import RxCocoa


final class AssetViewModel {
    //Property
    private let limit = 20
    private var offset = 0
    private var isLoading = false
    private var isFinished = false
    var assetsCount: Int {
        assetsBehavior.value.count
    }
    
    //API
    private let assetService: AssetService
    
    //RxSwift
    private var disposeBag = DisposeBag()
    private let assetsBehavior = BehaviorRelay<[Asset]>(value: [])
    private(set) lazy var assetsObservable = assetsBehavior.asObservable()
    
    init(assetService: AssetService = AssetService()) {
        self.assetService = assetService
    }
    
    // MARK: Public
    func reload() {
        clearData()
        fetchAssets(limit: limit, offset: offset)
    }
    
    func loadNextPage() {
        if isLoading || isFinished { return }
        offset += limit
        fetchAssets(limit: limit, offset: offset)
    }
    
    func retriveAsset(by index: Int) -> Asset {
        return assetsBehavior.value[index]
    }
    
    // MARK: private
    private func clearData() {
        disposeBag = DisposeBag()
        offset = 0
        assetsBehavior.accept([])
    }
    
    private func fetchAssets(limit: Int, offset: Int) {
        isLoading = true
        assetService.fetchAssets(limit: limit, offset: offset)
            .do(onNext: { [weak self] list in
                guard let self = self else { return }
                self.isFinished = list.assets.count < limit
                self.isLoading = false
            })
            .map({ [weak self] in
                guard let self = self else { return []}
                return self.assetsBehavior.value + $0.assets
            })
            .bind(to: assetsBehavior)
            .disposed(by: disposeBag)
    }
}
