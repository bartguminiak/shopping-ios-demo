//
//  ShoppingViewModelTests.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import XCTest
@testable import Shopping

class ShoppingListViewModelTests: XCTestCase {

    var sut: ShoppingListViewModel!
    var assemblyDouble: ShoppingListViewModelAssemblyDouble!

    override func setUp() {
        super.setUp()
        assemblyDouble = ShoppingListViewModelAssemblyDouble()

        sut = ShoppingListViewModel(assembly: assemblyDouble)
    }

    override func tearDown() {
        assemblyDouble = nil
        sut = nil
        super.tearDown()
    }

    func testItemTypes() {
        assemblyDouble.basketDouble.itemTypesStub = [.beans, .eggs, .peas, .milk]
        XCTAssert(sut.itemTypes == [.beans, .eggs, .peas, .milk])
    }

    func testItemCount() {
        assemblyDouble.basketDouble.returnPurchasedItemCountStub = 99
        XCTAssert(sut.itemCount(of: .milk) == 99)
    }

    func testAddingItem() {
        sut.add(.milk)
        XCTAssert(assemblyDouble.basketDouble.addItemSpy?.type == .milk)
    }

    func testAddItemAndReload() {
        var reloadCalled = false
        sut.reload = { reloadCalled = true }
        sut.add(.milk)
        XCTAssert(reloadCalled)
    }

    func testRemoveItem() {
        sut.remove(.peas)
        XCTAssert(assemblyDouble.basketDouble.removeItemSpy?.type == .peas)
    }

    func testRemoveItemAndReload() {
        var reloadCalled = false
        sut.reload = { reloadCalled = true }
        sut.remove(.peas)
        XCTAssert(reloadCalled)
    }

    func testSummaryScreenPresentation() {
        assemblyDouble.basketDouble.totalPriceInUSDStub = 99
        var viewControllerToPresent: UIViewController?
        sut.viewControllerPresentation = { vc in viewControllerToPresent = vc }
        sut.checkout()
        XCTAssert(viewControllerToPresent === assemblyDouble.navigationControllerStub)
    }

    func testSummaryScreenDismission() {
        assemblyDouble.basketDouble.totalPriceInUSDStub = 99
        var viewControllerToDismiss: UIViewController?
        sut.viewControllerDismission = { vc in viewControllerToDismiss = vc }
        sut.checkout()
        assemblyDouble.summaryViewControllerDouble.cancelSpy!()
        XCTAssert(viewControllerToDismiss === assemblyDouble.summaryViewControllerDouble)
    }

}
