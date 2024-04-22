//
//  SceneDelegate.swift
//  CombineProject
//
//  Created by Davidyoon on 4/19/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        
        let navigator = MenuNavigator(navigationController: navigationController)
        navigator.openView()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

