//
//  ShoppingTests.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 03/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import XCTest
@testable import Shopping

class BasketTests: XCTestCase {

    var sut: Basket!

    override func setUp() {
        super.setUp()
        sut = Basket()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testProperItems() {
        XCTAssert(sut.itemTypes == [.peas, .eggs, .milk, .beans])
    }
    
    func testEmptyBasket() {
        XCTAssert(sut.purchasedItems.isEmpty)
    }
    
    func testAddMilkItem() {
        sut.add(item: Item(type: .milk))
        XCTAssert(sut.purchasedItems.first!.type == .milk)
    }

    func testAddDifferentItems() {
        addVariousItems()
        XCTAssert(sut.purchasedItems.count == 6)
    }

    func testMilkCount() {
        addVariousItems()
        XCTAssert(sut.purchasedItemCount(of: .milk) == 2)
    }

    func testPeasCount() {
        addVariousItems()
        XCTAssert(sut.purchasedItemCount(of: .peas) == 1)
    }

    func testEggsCount() {
        addVariousItems()
        XCTAssert(sut.purchasedItemCount(of: .eggs) == 2)
    }

    func testBeansCount() {
        addVariousItems()
        XCTAssert(sut.purchasedItemCount(of: .beans) == 1)
    }

    func testRemovingMilkItem() {
        addVariousItems()
        sut.remove(item: Item(type: .milk))
        XCTAssert(sut.purchasedItemCount(of: .milk) == 1) 
    }

    func testRemovingFromEmptyBasket() {
        sut.remove(item: Item(type: .milk))
        XCTAssert(true)
    }

    func testSummingUpItems() {
        addVariousItems()
        XCTAssert(sut.totalPriceInUSD == 8.48)
    }

    // MARK: - Helpers

    private func addVariousItems() {
        sut.add(item: Item(type: .milk))
        sut.add(item: Item(type: .milk))
        sut.add(item: Item(type: .peas))
        sut.add(item: Item(type: .eggs))
        sut.add(item: Item(type: .beans))
        sut.add(item: Item(type: .eggs))
    }
    
}
