//
//  SummaryViewControllerCreatorStub.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit
@testable import Shopping

class SummaryViewControllerDouble: UIViewController, SummaryViewControllerDismission {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SummaryViewControllerDismission

    var cancel: (() -> Void)? {
        didSet {
            cancelSpy = cancel
        }
    }

    // MARK: - Doubles

    var cancelSpy: (() -> Void)?

}
