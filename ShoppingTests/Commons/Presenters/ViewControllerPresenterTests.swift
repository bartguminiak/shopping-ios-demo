//
//  ViewControllerPresenterTests.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 07/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import XCTest
@testable import Shopping

class ViewControllerPresenterTests: XCTestCase {

    var sut: ViewControllerPresenter!
    var presentViewControllerSpy: ViewControllerSpy!
    var baseViewControllerSpy: ViewControllerSpy!
    var dismissedViewControllerSpy: ViewControllerSpy!

    override func setUp() {
        super.setUp()
        dismissedViewControllerSpy = ViewControllerSpy()
        baseViewControllerSpy = ViewControllerSpy()
        presentViewControllerSpy = ViewControllerSpy()

        sut = ViewControllerPresenter()
    }

    override func tearDown() {
        dismissedViewControllerSpy = nil
        baseViewControllerSpy = nil
        presentViewControllerSpy = nil
        sut = nil
        super.tearDown()
    }

    func testBaseViewControllerWhilePresenting() {
        sut.present(viewController: presentViewControllerSpy, on: baseViewControllerSpy)
        XCTAssert(baseViewControllerSpy.baseViewController === baseViewControllerSpy)
    }

    func testPresentedViewControllerWhilePresenting() {
        sut.present(viewController: presentViewControllerSpy, on: baseViewControllerSpy)
        XCTAssert(baseViewControllerSpy.presentViewController === presentViewControllerSpy)
    }

    func testPresentingWithAnimation() {
        sut.present(viewController: presentViewControllerSpy, on: baseViewControllerSpy)
        XCTAssert(baseViewControllerSpy.presentViewControllerAnimated!)
    }

    func testViewControllerWhileDismissing() {
        sut.dismiss(viewController: dismissedViewControllerSpy)
        XCTAssert(dismissedViewControllerSpy.dismissViewController === dismissedViewControllerSpy)
    }

    func testDismissingWithAnimation() {
        sut.dismiss(viewController: dismissedViewControllerSpy)
        XCTAssert(dismissedViewControllerSpy.dismissViewControllerAnimated!)
    }

}
