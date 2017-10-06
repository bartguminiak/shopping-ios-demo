//
//  ShoppingViewModelDouble.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

@testable import Shopping

class ShoppingViewModelDouble: ShoppingListViewControllerInputs, ShoppingListViewControllerOutputs {

    // MARK: - ShoppingListViewControllerInputs

    var itemTypes: [ItemType] {
        return itemTypesStub
    }

    func itemCount(of type: ItemType) -> Int {
        itemCountTypeSpy = type
        return returnItemCountStub
    }

    var viewControllerPresentation: ((UIViewController) -> Void)? {
        didSet {
            viewControllerPresentationSpy = viewControllerPresentation
        }
    }

    var viewControllerDismission: ((UIViewController) -> Void)? {
        didSet {
            viewControllerDismissionSpy = viewControllerDismission
        }
    }

    var reload: (() -> Void)? {
        didSet {
            reloadSpy = reload
        }
    }

    // MARK: - ShoppingListViewControllerOutputs

    func add(_ type: ItemType) {
        addItemTypeSpy = type
    }

    func remove(_ type: ItemType) {
        removeItemTypeSpy = type
    }

    func checkout() {
        checkoutCalled = true
    }

    // MARK: - Doubles

    var itemTypesStub = [ItemType]()
    var itemCountTypeSpy: ItemType?
    var returnItemCountStub: Int!
    var viewControllerPresentationSpy: ((UIViewController) -> Void)?
    var viewControllerDismissionSpy: ((UIViewController) -> Void)?
    var reloadSpy: (() -> Void)?
    var addItemTypeSpy: ItemType?
    var removeItemTypeSpy: ItemType?
    var checkoutCalled = false

}

