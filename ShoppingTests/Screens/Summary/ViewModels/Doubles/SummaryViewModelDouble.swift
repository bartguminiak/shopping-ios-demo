//
//  SummaryViewModelDouble.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 07/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import Foundation
@testable import Shopping

class SummaryViewModelDouble: SummaryViewControllerInputs, SummaryViewControllerOutputs {

    // MARK: - SummaryViewControllerInputs

    var summaryTitle: String {
        return summaryTitleStub
    }

    var summaryPrice: String {
        return summaryPriceStub
    }

    var updateSummaryPrice: ((String) -> Void)? {
        didSet {
            updateSummaryPriceSpy = updateSummaryPrice
        }
    }

    var currencyRates: [String] {
        return currencyRatesStub
    }

    var reload: (() -> Void)? {
        didSet {
            reloadSpy = reload
        }
    }

    // MARK: - SummaryViewControllerOutputs

    func select(row: Int) {
        rowSelected = row
    }

    // MARK: - Doubles

    var summaryTitleStub: String!
    var summaryPriceStub: String!
    var updateSummaryPriceSpy: ((String) -> Void)?
    var currencyRatesStub: [String]!
    var reloadSpy: (() -> Void)?
    var rowSelected: Int?

}
