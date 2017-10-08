//
//  DoubleRountingTests.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 08/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import XCTest
@testable import Shopping

class DoubleRoundingTests: XCTestCase {

    var sut: Double!

    func testRounding() {
        sut = 1.234567
        XCTAssert(sut.round(to: 2) == 1.23)
    }

    func testRoundingUp() {
        sut = 1.34678
        XCTAssert(sut.round(to: 2) == 1.35)
    }
}
