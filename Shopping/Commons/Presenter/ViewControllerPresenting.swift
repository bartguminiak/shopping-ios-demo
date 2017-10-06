//
//  ViewControllerPresenting.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 04/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

protocol ViewControllerPresenting {
    func present(viewController: UIViewController, on baseViewController: UIViewController)
    func dismiss(viewController: UIViewController)
}
