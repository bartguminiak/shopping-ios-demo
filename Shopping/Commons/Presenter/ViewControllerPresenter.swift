//
//  ViewControllerPresenter.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 04/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

class ViewControllerPresenter: ViewControllerPresenting {

    func present(viewController: UIViewController, on baseViewController: UIViewController) {
        baseViewController.present(viewController, animated: true, completion: nil)
    }

    func dismiss(viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

}
