//
//  Container_AppDelegateAssembly.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 04/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

extension Container {

    var appDelegateAssembly: AppDelegateAssembly {
        return Assembly(container: self)
    }

    private struct Assembly: AppDelegateAssembly {

        let container: Container

        // MARK: - AppDelegateAssembly
        
        func makeWindow(in windowScene: UIWindowScene) -> UIWindow {
            UIWindow(windowScene: windowScene)
        }

        var rootViewController: UIViewController {
            return container.shoppingListViewController
        }

    }

}
