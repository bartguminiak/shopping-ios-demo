//
//  BasketOperating.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 04/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import Foundation

protocol BasketOperating {

    var itemTypes: [ItemType] { get }
    func add(item: Item)
    func remove(item: Item)
    func purchasedItemCount(of type: ItemType) -> Int
    var purchasedItems: [Item] { get }
    var totalPriceInUSD: Double { get }

}
