//
//  CurrencyRateProvider.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 06/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import Foundation

class CurrencyRateProvider: CurrencyRateProviding {

    init(quotes: [String] = ["EUR", "GBP", "CAD", "PLN", "CHF", "NOK"]) {
        self.quotes = quotes
    }

    // MARK: - CurrencyRateProviding

    func getCurrencies(completion: @escaping ([Currency], Error?) -> Void) {
        dataTask?.cancel()
        self.completion = completion

        if var urlComponents = URLComponents(string: currencyRatesUrl) {
            urlComponents.query = query
            guard let url = urlComponents.url else { return }

            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                guard let `self` = self else { return }
                defer { self.dataTask = nil }
                if let error = error { self.completion?([], error) }
                else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    do {
                        let currencyRates = try self.currencyRates(from: data)
                        self.returnOnMainThread(currencyRates, nil)
                    } catch {
                        self.returnOnMainThread([], error)
                    }
                } else {
                    self.returnOnMainThread([], NSError(domain: "pl.guminiak.currency_response_unknown_error",
                                                          code: 0,
                                                      userInfo: nil)) }
            }
            dataTask?.resume()
        }
    }

    // MARK: - Privates

    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    private let decoder = JSONDecoder()

    private let currencyRatesUrl = "http://apilayer.net/api/live"
    private var query: String {
        let quotesString = quotes.reduce("", { $0 + "," + $1 })
        return "access_key=dcd7e0723d29d5a1a7a8c795fa5efe4c&currencies=\(quotesString)&source=USD&format=1"
    }
    private let quotes: [String]

    private var completion: (([Currency], Error?) -> Void)?

    private func currencyRates(from data: Data) throws -> [Currency] {
        let currencyResponse = try decoder.decode(CurrencyResponse.self, from: data)
        return currencyResponse.quotes.map { Currency(name: $0.key, rate: $0.value) }
    }

    private func returnOnMainThread(_ currencyRates: [Currency], _ error: Error?) {
        DispatchQueue.main.async {
            self.completion?(currencyRates, error)
        }
    }

}
