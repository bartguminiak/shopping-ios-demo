//
//  Item_Fixtures.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 04/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

extension ItemType {

    var name: String {
        switch self {
        case .peas: return "Peas"
        case .eggs: return "Eggs"
        case .milk: return "Milk"
        case .beans: return "Beans"
        }
    }

    var priceInUSD: Double {
        switch self {
        case .peas: return 0.95
        case .eggs: return 2.1
        case .milk: return 1.3
        case .beans: return 0.73
        }
    }

    var unit: String {
        switch self {
        case .peas: return "bag"
        case .eggs: return "dozen"
        case .milk: return "bottle"
        case .beans: return "can"
        }
    }

}
