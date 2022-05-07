//
//  ApplicationCoordinator.swift
//  Portto
//
//  Created by Vincent on 2022/5/7.
//

import Foundation
import UIKit

final class ApplicationCoordinator: Coordinator {
    
    private let window: UIWindow
    private let factory: ApplicationCoordinatorFactory
    
    init(factory: ApplicationCoordinatorFactory, window: UIWindow) {
        self.window = window
        self.factory = factory
    }
    
    override func start() {
        runAssetFlow()
    }
    
    func runAssetFlow() {
        let coordinator = factory.makeAssetCoordinator(window: window)
        store(coordinator: coordinator)
        coordinator.start()
    }
}


func makeAppCoordinator(window: UIWindow) -> ApplicationCoordinator? {
    let factory = ApplicationCoordinatorFactoryImp()
    return ApplicationCoordinator(factory: factory, window: window)
}
