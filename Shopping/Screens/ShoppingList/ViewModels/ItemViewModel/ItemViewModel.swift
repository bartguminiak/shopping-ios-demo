//
//  ItemViewModel.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 04/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import Foundation

protocol ItemViewModelPresentable {
    var displayTitle: String { get }
    var count: Int { get }
}

struct ItemViewModel: ItemViewModelPresentable {

    let displayTitle: String
    let count: Int

    init(type: ItemType, count: Int) {
        self.displayTitle = "\(type.name): $ \(type.priceInUSD) per \(type.unit)"
        self.count = count
    }

}
