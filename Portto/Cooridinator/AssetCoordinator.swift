//
//  AssetCoordinator.swift
//  Portto
//
//  Created by Vincent on 2022/5/7.
//

import UIKit

final class AssetCoordinator: Coordinator {
    
    private let navigationController = UINavigationController()
    private let factory: AssetCoordinatorFactory
    private let window: UIWindow
    
    init(factory: AssetCoordinatorFactory, window: UIWindow) {
        self.factory = factory
        self.window = window
    }
    
    override func start() {
        runAssetViewController()
    }
    
    private func runAssetViewController() {
        let assetViewController = factory.makeAssetViewController()
        assetViewController.didSelectedAsset = { [weak self] asset in
            self?.runAssetDetailViewController(asset: asset)
        }
        
        navigationController.viewControllers = [assetViewController]
        window.rootViewController = navigationController
    }
    
    private func runAssetDetailViewController(asset: Asset) {
        let controller = factory.makeAssetDetailViewController(asset: asset)
        navigationController.pushViewController(controller, animated: true)
    }
}
