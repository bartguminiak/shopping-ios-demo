//
//  SceneDelegate.swift
//  Shopping
//
//  Created by Bartlomiej on 30/10/2026.
//  Copyright © 2026 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene,
              let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }

        let assembly = appDelegate.assembly
        let window = assembly.makeWindow(in: windowScene)
        window.rootViewController = assembly.rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}
