//
//  Container_SummaryViewModel.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 06/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

extension Container {

    var summaryViewModel: SummaryViewModel {
        return SummaryViewModel(assembly: Assembly(container: self))
    }

    private struct Assembly: SummaryViewModelAssembly {

        let container: Container

        // MARK: - SummaryViewModelAssembly

        var basket: BasketOperating {
            return container.basket
        }

        var provider: CurrencyRateProviding {
            return CurrencyRateProvider()
        }

    }

}
