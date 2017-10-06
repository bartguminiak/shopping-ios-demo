//
//  ShoppingListViewControllerAssemblyDouble.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

@testable import Shopping

class ShoppingListViewControllerAssemblyDouble: ShoppingListViewControllerAssembly {
    
    var presenter: ViewControllerPresenting {
        return presenterSpy
    }

    var itemViewModelCreator: ItemViewModelCreating {
        return itemViewModelCreatorStub
    }


    // MARK: - Doubles

    var presenterSpy = ViewControllerPresenterSpy()
    var itemViewModelCreatorStub = ItemViewModelCreatorStub()

}
