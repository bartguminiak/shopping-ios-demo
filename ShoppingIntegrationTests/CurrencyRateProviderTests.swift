//
//  ShoppingIntegrationTests.swift
//  ShoppingIntegrationTests
//
//  Created by Bartlomiej Guminiak on 07/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import XCTest
@testable import Shopping

class CurrencyRateProviderTests: XCTestCase {

    var sut: CurrencyRateProvider!
    
    func testCurrencies() {
        sut = CurrencyRateProvider(quotes: ["CHF", "PLN"])
        let expectation = XCTestExpectation(description: "Request currencies")

        sut.getCurrencies { (currencies, error) in
            XCTAssert(currencies.count == 2)
            XCTAssert(currencies.map { $0.name }.contains("USDCHF"))
            XCTAssert(currencies.map { $0.name }.contains("USDPLN"))
            XCTAssert(error == nil)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testUnknownCurrencies() {
        sut = CurrencyRateProvider(quotes: ["unknown"])
        let expectation = XCTestExpectation(description: "Request currencies")

        sut.getCurrencies { (currencies, error) in
            XCTAssert(currencies.isEmpty)
            XCTAssert(error != nil)

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
    
}
