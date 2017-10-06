//
//  Basket.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 03/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

class Basket: BasketOperating {

    let itemTypes: [ItemType] = [.peas, .eggs, .milk, .beans]

    func add(item: Item) {
        purchasedItems.append(item)
    }

    func remove(item: Item) {
        if let index = purchasedItems.index(where: { item.type == $0.type }) {
            purchasedItems.remove(at: index)
        }
    }

    func purchasedItemCount(of type: ItemType) -> Int {
        return purchasedItems.filter { $0.type == type }.count
    }

    private(set) var purchasedItems = [Item]()

    var totalPriceInUSD: Double {
        return purchasedItems.map { $0.type.priceInUSD }.reduce(0, +)
    }

}

