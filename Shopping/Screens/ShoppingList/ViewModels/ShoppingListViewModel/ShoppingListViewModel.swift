//
//  ShoppingListViewModel.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 04/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

protocol ShoppingListViewModelAssembly {
    var basket: BasketOperating { get }
    var summaryViewController: UIViewController & SummaryViewControllerDismission { get }
    func navigationController(with viewController: UIViewController) -> UINavigationController
}

class ShoppingListViewModel: ShoppingListViewControllerInputs, ShoppingListViewControllerOutputs {

    init(assembly: ShoppingListViewModelAssembly) {
        self.assembly = assembly
        self.basket = assembly.basket
    }

    // MARK: - ShoppingListViewControllerInputs

    var itemTypes: [ItemType] {
        return basket.itemTypes
    }

    func itemCount(of type: ItemType) -> Int {
        return basket.purchasedItemCount(of: type)
    }

    var viewControllerPresentation: ((UIViewController) -> Void)?

    var viewControllerDismission: ((UIViewController) -> Void)?

    var reload: (() -> Void)?

    // MARK: - ShoppingListViewControllerOutputs

    func add(_ type: ItemType) {
        let item = Item(type: type)
        basket.add(item: item)
        reload?()
    }

    func remove(_ type: ItemType) {
        let item = Item(type: type)
        basket.remove(item: item)
        reload?()
    }

    func checkout() {
        let viewController = assembly.summaryViewController
        viewController.cancel = { [weak self, weak viewController] in
            if let viewController = viewController {
                self?.viewControllerDismission?(viewController)
            }
        }
        let navigationController = assembly.navigationController(with: viewController)
        viewControllerPresentation?(navigationController)
    }

    // MARK: - Privates

    private let assembly: ShoppingListViewModelAssembly
    private let basket: BasketOperating

}
