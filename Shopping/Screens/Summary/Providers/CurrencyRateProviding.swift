//
//  CurrencyRateProviding.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 06/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

protocol CurrencyRateProviding {
    func getCurrencies(completion: @escaping ([Currency], Error?) -> Void)
}
