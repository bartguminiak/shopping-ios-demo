//
//  SummaryViewModelAssemblyDouble.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 07/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import Foundation
@testable import Shopping

class SummaryViewModelAssemblyDouble: SummaryViewModelAssembly {

    var basket: BasketOperating {
        return basketDouble
    }

    var provider: CurrencyRateProviding {
        return providerDouble
    }

    // MARK: - Doubles

    var basketDouble = BasketDouble()
    var providerDouble = CurrencyRateProviderDouble()

}
