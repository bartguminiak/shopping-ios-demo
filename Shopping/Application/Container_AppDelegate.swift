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

        var window: UIWindow {
            return UIWindow(frame: UIScreen.main.bounds)
        }

        var rootViewController: UIViewController {
            return container.shoppingListViewController
        }

    }

}
