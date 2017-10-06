//
//  ItemViewModelCreator.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

class ItemViewModelCreator: ItemViewModelCreating {

    func create(with type: ItemType, count: Int) -> ItemViewModelPresentable {
        return ItemViewModel(type: type, count: count)
    }

}
