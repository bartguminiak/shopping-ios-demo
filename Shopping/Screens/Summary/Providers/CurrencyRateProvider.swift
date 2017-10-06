//
//  CurrencyRateProvider.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 06/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import Foundation

class CurrencyRateProvider: CurrencyRateProviding {

    // TODO: inject via protocol
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    // MARK: - CurrencyRateProviding

    func getCurrencies(completion: @escaping ([Currency], Error?) -> Void) {
        dataTask?.cancel()
        self.completion = completion

        // TODO: refactor
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
                } else { self.returnOnMainThread([], NSError()) }
            }
            dataTask?.resume()
        }
    }

    // MARK: - Privates

    private let currencyRatesUrl = "http://apilayer.net/api/live"
    private let query = "access_key=dcd7e0723d29d5a1a7a8c795fa5efe4c&currencies=EUR,GBP,CAD,PLN&source=USD&format=1"

    private var completion: (([Currency], Error?) -> Void)?

    private func currencyRates(from data: Data) throws -> [Currency] {
        let decoder = JSONDecoder()
        let currencyResponse = try decoder.decode(CurrencyResponse.self, from: data)
        return currencyResponse.quotes.map { Currency(name: $0.key, rate: $0.value) }
    }

    private func returnOnMainThread(_ currencyRates: [Currency], _ error: Error?) {
        DispatchQueue.main.async {
            self.completion?(currencyRates, error)
        }
    }

}
