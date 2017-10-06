//
//  CurrencyResponse.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 06/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

struct CurrencyResponse: Codable {
    let success: Bool
    let quotes: [String: Double]
}
