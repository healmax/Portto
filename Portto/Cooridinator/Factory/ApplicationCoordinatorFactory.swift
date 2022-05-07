//
//  ApplicationCoordinatorFactory.swift
//  Portto
//
//  Created by Vincent on 2022/5/7.
//

import Foundation
import UIKit

protocol ApplicationCoordinatorFactory {
    func makeAssetCoordinator(window: UIWindow) -> AssetCoordinator
}

struct ApplicationCoordinatorFactoryImp: ApplicationCoordinatorFactory {
    func makeAssetCoordinator(window: UIWindow) -> AssetCoordinator {
        let factory = AssetCoordinatorFactoryIMP()
        let coordinator = AssetCoordinator(factory: factory, window: window)
        return coordinator
    }
}
