//
//  ViewControllerPresenterSpy.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

@testable import Shopping

class ViewControllerPresenterSpy: ViewControllerPresenting {

    func present(viewController: UIViewController, on baseViewController: UIViewController) {
        presentedViewController = viewController
        onBaseViewController = baseViewController
    }

    func dismiss(viewController: UIViewController) {
        dismissedViewController = viewController
    }

    // MARK: - Spies

    var presentedViewController: UIViewController?
    var onBaseViewController: UIViewController?
    var dismissedViewController: UIViewController?

}
