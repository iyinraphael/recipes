//
//  SceneDelegate.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/21/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navCon = UINavigationController()
        appCoordinator = AppCoordinator(navCon: navCon)
        appCoordinator?.start()
        
        window?.rootViewController = navCon
        window?.makeKeyAndVisible()
    }
}

