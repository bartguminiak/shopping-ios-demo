//
//  ShoppingListViewModelAssemblyDouble.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit
@testable import Shopping

class ShoppingListViewModelAssemblyDouble: ShoppingListViewModelAssembly {

    var basket: BasketOperating {
        return basketDouble
    }

    var summaryViewController: UIViewController & SummaryViewControllerDismission {
        return summaryViewControllerDouble
    }

    func navigationController(with viewController: UIViewController) -> UINavigationController {
        return navigationControllerStub
    }

    // MARK: - Doubles

    var basketDouble = BasketDouble()
    var summaryViewControllerDouble = SummaryViewControllerDouble()
    var navigationControllerStub = UINavigationController(nibName: nil, bundle: nil)

}
