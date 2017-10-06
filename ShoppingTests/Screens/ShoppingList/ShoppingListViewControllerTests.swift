//
//  ShoppingListViewControllerTests.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import XCTest
@testable import Shopping

class ShoppingListViewControllerTests: XCTestCase {

    var sut: ShoppingListViewController!
    var assemblyDouble: ShoppingListViewControllerAssemblyDouble!
    var viewModelDouble: ShoppingViewModelDouble!
    var shoppingListView: ShoppingListView!

    override func setUp() {
        super.setUp()
        assemblyDouble = ShoppingListViewControllerAssemblyDouble()
        viewModelDouble = ShoppingViewModelDouble()

        sut = ShoppingListViewController(assembly: assemblyDouble, viewModel: viewModelDouble)
        shoppingListView = sut.view as! ShoppingListView
    }

    override func tearDown() {
        viewModelDouble = nil
        assemblyDouble = nil
        sut = nil
        super.tearDown()
    }

    func textTableViewDataSourceConfiguration() {
        XCTAssert(shoppingListView.tableView.dataSource === sut)
    }

    func testTableViewShouldHaveTwoCells() {
        viewModelDouble.itemTypesStub = [.milk, .peas, .eggs]
        viewModelDouble.reloadSpy!()
        XCTAssert(shoppingListView.tableView.numberOfRows(inSection: 0) == 3)
    }

    func testTitleItemCell() {
        prepareTestCell()

        let cell = shoppingListView.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ItemCell
        let titleLabel = cell.contentView.subviews.first as! UILabel
        XCTAssert(titleLabel.text == "test item title")
    }

    func testCounterItemCell() {
        prepareTestCell()

        let cell = shoppingListView.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ItemCell
        let counterView = cell.contentView.subviews[1] as! CounterView
        let counterLabel = counterView.subviews[1] as! UILabel
        XCTAssert(counterLabel.text == "99")
    }

    func testAddingItemToBasket() {
        prepareTestCell()

        let cell = shoppingListView.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ItemCell
        let counterView = cell.contentView.subviews[1] as! CounterView
        let plusButton = counterView.subviews[2] as! UIButton
        plusButton.sendActions(for: .touchUpInside)
        XCTAssert(viewModelDouble.addItemTypeSpy == .milk)
    }

    func testRemovingItemFromBasket() {
        prepareTestCell()

        let cell = shoppingListView.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ItemCell
        let counterView = cell.contentView.subviews[1] as! CounterView
        let plusButton = counterView.subviews.first as! UIButton
        plusButton.sendActions(for: .touchUpInside)
        XCTAssert(viewModelDouble.removeItemTypeSpy == .milk)
    }

    func testCheckoutButton() {
        shoppingListView.checkoutButton.sendActions(for: .touchUpInside)
        XCTAssert(viewModelDouble.checkoutCalled)
    }

    func testViewControllerPresentation() {
        let testViewController = UIViewController(nibName: nil, bundle: nil)
        viewModelDouble.viewControllerPresentationSpy!(testViewController)
        XCTAssert(assemblyDouble.presenterSpy.presentedViewController === testViewController)
    }

    func testViewControllerDismission() {
        let testViewController = UIViewController(nibName: nil, bundle: nil)
        viewModelDouble.viewControllerDismissionSpy!(testViewController)
        XCTAssert(assemblyDouble.presenterSpy.dismissedViewController === testViewController)
    }

    // MARK: - Helpers

    private func prepareTestCell() {
        viewModelDouble.itemTypesStub = [.milk]
        viewModelDouble.returnItemCountStub = 9
        assemblyDouble.itemViewModelCreatorStub.itemViewModelStub.displayTitleStub = "test item title"
        assemblyDouble.itemViewModelCreatorStub.itemViewModelStub.countStub = 99
        viewModelDouble.reloadSpy!()
    }

}
