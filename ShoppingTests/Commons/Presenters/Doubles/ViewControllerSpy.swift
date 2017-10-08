//
//  ViewControllerSpy.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 07/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit
@testable import Shopping

class ViewControllerSpy: UIViewController {

    override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        baseViewController = self
        presentViewController = viewControllerToPresent
        presentViewControllerAnimated = flag
        completion?()
    }

    override func dismiss(animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        dismissViewController = self
        dismissViewControllerAnimated = flag
        completion?()
    }

    // MARK: - Spies

    weak var baseViewController: UIViewController?
    weak var presentViewController: UIViewController?
    var presentViewControllerAnimated: Bool?

    weak var dismissViewController: UIViewController?
    var dismissViewControllerAnimated: Bool?

}
