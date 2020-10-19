//
//  SceneDelegate.swift
//  TestMobileUp
//
//  Created by Матвей Чернышев on 19.10.2020.
//

import UIKit

final class SceneDelegate: UIResponder {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = .init(windowScene: windowScene)
        
        window?.rootViewController = makeNavController()
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate: UIWindowSceneDelegate {}

private extension SceneDelegate {
    
    func makeNavController() -> UIViewController {
        return UINavigationController(rootViewController: ChatsListViewController())
    }
}
