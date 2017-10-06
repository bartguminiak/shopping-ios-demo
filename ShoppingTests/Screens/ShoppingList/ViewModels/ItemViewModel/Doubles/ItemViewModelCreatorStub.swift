//
//  ItemViewModelCreatorStub.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

@testable import Shopping

class ItemViewModelCreatorStub: ItemViewModelCreating {

    func create(with type: ItemType, count: Int) -> ItemViewModelPresentable {
        itemTypeSpy = type
        countSpy = count
        return itemViewModelStub
    }

    // MARK: - Doubles

    var itemTypeSpy: ItemType?
    var countSpy: Int?
    var itemViewModelStub = ItemViewModelStub()

}
