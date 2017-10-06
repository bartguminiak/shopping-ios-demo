//
//  Container_ShoppingListViewController.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 04/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

extension Container {

    var shoppingListViewController: UIViewController {
        let viewModel = shoppingListViewModel
        return ShoppingListViewController(assembly: Assembly(), viewModel: viewModel)
    }

    private struct Assembly: ShoppingListViewControllerAssembly {

        var presenter: ViewControllerPresenting {
            return ViewControllerPresenter()
        }

        var itemViewModelCreator: ItemViewModelCreating {
            return ItemViewModelCreator()
        }

    }

}
