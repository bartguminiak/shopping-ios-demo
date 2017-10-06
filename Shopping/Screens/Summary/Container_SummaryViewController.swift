//
//  Container_SummaryViewController.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 06/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

extension Container {

    var summaryViewController: SummaryViewController {
        return SummaryViewController(viewModel: summaryViewModel)
    }

}
