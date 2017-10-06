//
//  Container_Basket.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 04/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

extension Container {

    var shoppingListViewModel: ShoppingListViewModel {
        return ShoppingListViewModel(assembly: Assembly(container: self))
    }

    private struct Assembly: ShoppingListViewModelAssembly {

        let container: Container

        // MARK: - ShoppingListViewModelAssembly

        var basket: BasketOperating {
            return container.basket
        }

        var summaryViewController: UIViewController & SummaryViewControllerDismission {
            return container.summaryViewController
        }

        func navigationController(with viewController: UIViewController) -> UINavigationController {
            return UINavigationController(rootViewController: viewController)
        }

    }

}
