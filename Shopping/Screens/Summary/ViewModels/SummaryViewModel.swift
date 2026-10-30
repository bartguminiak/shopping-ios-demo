//
//  SummaryViewModel.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import Foundation

protocol SummaryViewModelAssembly {
    var basket: BasketOperating { get }
    var provider: CurrencyRateProviding { get }
}

class SummaryViewModel: SummaryViewControllerInputs, SummaryViewControllerOutputs {

    init(assembly: SummaryViewModelAssembly) {
        self.basket = assembly.basket
        self.provider = assembly.provider
        self.summaryTitle = "Summary for \(basket.purchasedItems.count) items"
        self.summaryPrice = summaryPrice()
        self.updateRates()
    }

    // MARK: - SummaryViewControllerInputs

    let summaryTitle: String

    private(set) var summaryPrice: String = ""

    var updateSummaryPrice: ((String) -> Void)?

    private(set) var currencyRates = [String]()
    
    var reload: (() -> Void)?

    // MARK: - SummaryViewControllerOutputs

    func select(row: Int) {
        guard storedCurrencies.indices.contains(row) else { return }
        let currency = storedCurrencies[row]
        summaryPrice = summaryPrice(with: currency)
        updateSummaryPrice?(summaryPrice)
    }

    // MARK: - Privates

    private let basket: BasketOperating
    private let provider: CurrencyRateProviding

    private var storedCurrencies = [Currency]()

    private func updateRates() {
        self.provider.getCurrencies(completion: { [weak self] currencyRates, error in
            if let error = error { print(error) }
            else {
                self?.storedCurrencies = currencyRates
                self?.currencyRates = currencyRates.map { "\($0.name) at rate \($0.rate)" }
                self?.reload?()
            }
        })
    }

    private func summaryPrice(with currency: Currency? = nil) -> String {
        guard let currency = currency else { return "Your price is \(basket.totalPriceInUSD) USD" }
        let price = (basket.totalPriceInUSD * currency.rate).round(to: 2)
        let quote = currency.name.suffix(3)
        return "Your price is \(price) \(quote)"
    }
    
}
