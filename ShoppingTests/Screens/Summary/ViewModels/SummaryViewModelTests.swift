//
//  SummaryViewModelTests.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 07/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import XCTest
@testable import Shopping

class SummaryViewModelTests: XCTestCase {

    var sut: SummaryViewModel!
    var viewModelDouble: SummaryViewModelAssemblyDouble!
    var testCurrencies: [Currency]!

    override func setUp() {
        super.setUp()
        viewModelDouble = SummaryViewModelAssemblyDouble()
        viewModelDouble.basketDouble.purchasedItemsStub = [Item(type: .milk)]
        viewModelDouble.basketDouble.totalPriceInUSDStub = 99.9
        sut = SummaryViewModel(assembly: viewModelDouble)
        testCurrencies = [
            Currency(name: "ABCDEF", rate: 1.1),
            Currency(name: "GHIJKLMN", rate: 2.2)
        ]
    }

    override func tearDown() {
        viewModelDouble = nil
        sut = nil
        super.tearDown()
    }

    func testSummaryTitle() {
        XCTAssert(sut.summaryTitle == "Summary for 1 items")
    }

    func testSummaryPrice() {
        XCTAssert(sut.summaryPrice == "Your price is 99.9 USD")
    }

    func testCurrencyRates() {
        viewModelDouble.providerDouble.completionStub!(testCurrencies, nil)
        XCTAssert(sut.currencyRates == ["ABCDEF at rate 1.1", "GHIJKLMN at rate 2.2"])
    }

    func testCurrencyRatesError() {
        viewModelDouble.providerDouble.completionStub!([], NSError(domain: "", code: 0, userInfo: nil))
        XCTAssert(sut.currencyRates.isEmpty)
    }

    func testSelectingFirstRow() {
        var newSummaryPrice: String?
        sut.updateSummaryPrice = { newSummaryPrice = $0 }
        viewModelDouble.providerDouble.completionStub!(testCurrencies, nil)
        sut.select(row: 0)
        XCTAssert(newSummaryPrice == "Your price is 109.89 DEF")
    }

    func testSelectingUnexistingRow() {
        sut.select(row: 999)
        XCTAssert(true)
    }

}
