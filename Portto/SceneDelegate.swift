//
//  SceneDelegate.swift
//  Portto
//
//  Created by Vincent on 2022/5/5.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: ApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.makeKeyAndVisible()
        self.appCoordinator = makeAppCoordinator(window: window!)
        self.appCoordinator?.start()
    }
}

