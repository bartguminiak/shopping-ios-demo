//
//  CurrencyRateProviderDouble.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 07/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import Foundation
@testable import Shopping

class CurrencyRateProviderDouble: CurrencyRateProviding {

    func getCurrencies(completion: @escaping ([Currency], Error?) -> Void) {
        completionStub = completion
    }

    // MARK: - Doubles

    var completionStub: (([Currency], Error?) -> Void)?

}
