//
//  UIControl_BlockAction.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 07/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

extension UIControl {

    func addAction(for controlEvents: UIControlEvents, action: @escaping () -> Void) {
        let sleeve = ClosureSleeve(attachTo: self, closure: action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
    }

}

extension UIBarButtonItem {

    func addAction(_ closureAction: @escaping () -> Void) {
        let sleeve = ClosureSleeve(attachTo: self, closure: closureAction)
        target = sleeve
        action = #selector(ClosureSleeve.invoke)
    }

}

private class ClosureSleeve {

    let closure: () -> ()

    init(attachTo: AnyObject, closure: @escaping () -> ()) {
        self.closure = closure
        objc_setAssociatedObject(attachTo, "[\(arc4random())]", self, .OBJC_ASSOCIATION_RETAIN)
    }

    @objc func invoke() {
        closure()
    }
    
}
