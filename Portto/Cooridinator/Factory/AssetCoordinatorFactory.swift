//
//  AssetCoordinatorFactory.swift
//  Portto
//
//  Created by Vincent on 2022/5/7.
//

import UIKit

protocol AssetCoordinatorFactory {
    func makeAssetViewController() -> AssetViewController
    func makeAssetDetailViewController(asset: Asset) -> AssetDetailViewController
}

struct AssetCoordinatorFactoryIMP: AssetCoordinatorFactory {
    func makeAssetViewController() -> AssetViewController {
        let controller = AssetViewController()
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        controller.navigationItem.backBarButtonItem = item
        return controller
    }
    func makeAssetDetailViewController(asset: Asset) -> AssetDetailViewController {
        let viewModel = AssetDetailViewModel(asset: asset)
        let controller =  AssetDetailViewController(viewModel: viewModel)
        return controller
    }
}
