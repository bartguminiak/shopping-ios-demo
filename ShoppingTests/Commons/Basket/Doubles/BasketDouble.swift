//
//  BasketDouble.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import Foundation
@testable import Shopping

class BasketDouble: BasketOperating {

    var itemTypes: [ItemType] {
        return itemTypesStub
    }

    func add(item: Item) {
        addItemSpy = item
    }

    func remove(item: Item) {
        removeItemSpy = item
    }

    func purchasedItemCount(of type: ItemType) -> Int {
        purchasedItemCountTypeSpy = type
        return returnPurchasedItemCountStub
    }

    var purchasedItems: [Item] {
        return purchasedItemsStub
    }

    var totalPriceInUSD: Double {
        return totalPriceInUSDStub
    }

    // MARK: - Doubles

    var itemTypesStub: [ItemType]!
    var addItemSpy: Item?
    var removeItemSpy: Item?
    var purchasedItemCountTypeSpy: ItemType?
    var returnPurchasedItemCountStub: Int!
    var purchasedItemsStub: [Item]!
    var totalPriceInUSDStub: Double!

}
