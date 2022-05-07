//
//  Coordinator.swift
//  Portto
//
//  Created by Vincent on 2022/5/7.
//

import Foundation

class Coordinator {
    
    /// Identifier of coordinator.
    ///
    /// Used to add/remove dependency.
    let identifier: UUID = .init()

    /// Child coordinators belong to current coordinator.
    ///
    /// Can be used if any deep link option has passed in for further setup...
    var childCoordinators: [UUID: Coordinator] = [:]

    /// Start coordinator without any option.
    func start() {
        fatalError("start(with:) is not implemented yet")
    }

    /// Add coordinator to child coordinator dictionary.
    ///
    /// - Parameter coordinator: coordinator to store
    func store(coordinator: Coordinator) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    /// Remove coordinator from child coordinators list.
    ///
    /// - Parameter coordinator: coordinator to remove.
    func free(coordinator: Coordinator) {
        childCoordinators.removeValue(forKey: coordinator.identifier)
    }

    func clear() {
        childCoordinators = [:]
    }
}
