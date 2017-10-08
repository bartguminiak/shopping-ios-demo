//
//  Double_Rounding.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 08/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import Foundation

extension Double {

    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }

}
