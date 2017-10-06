//
//  ItemViewModelStub.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

@testable import Shopping

class ItemViewModelStub: ItemViewModelPresentable {

    var displayTitle: String {
        return displayTitleStub
    }

    var count: Int {
        return countStub
    }

    // MARK: - Stubs

    var displayTitleStub: String!
    var countStub: Int!

}
