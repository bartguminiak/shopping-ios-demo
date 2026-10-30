//
//  AppDelegate.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 03/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

//protocol AppDelegateAssembly {
//    var window: UIWindow { get }
//    var rootViewController: UIViewController { get }
//}

protocol AppDelegateAssembly {
    func makeWindow(in windowScene: UIWindowScene) -> UIWindow
    var rootViewController: UIViewController { get }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var assembly: AppDelegateAssembly = Container().appDelegateAssembly

    // MARK: - UIApplicationDelegate

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

}
