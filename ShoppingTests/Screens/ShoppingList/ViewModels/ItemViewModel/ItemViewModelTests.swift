//
//  ItemViewModelTests.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 08/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import XCTest
@testable import Shopping

class ItemViewModelTests: XCTestCase {

    var sut: ItemViewModel!

    override func setUp() {
        super.setUp()
        sut = ItemViewModel(type: .milk, count: 9)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testDisplayTitle() {
        XCTAssert(sut.displayTitle == "Milk: $ 1.3 per bottle")
    }

    func testItemCount() {
        XCTAssert(sut.count == 9)
    }
    
}
