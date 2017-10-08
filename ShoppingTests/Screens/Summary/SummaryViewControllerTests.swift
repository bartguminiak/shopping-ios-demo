//
//  SummaryViewControllerTests.swift
//  ShoppingTests
//
//  Created by Bartlomiej Guminiak on 07/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import XCTest
@testable import Shopping

class SummaryViewControllerTests: XCTestCase {

    var sut: SummaryViewController!
    var viewModelDouble: SummaryViewModelDouble!
    var summaryView: SummaryView!

    override func setUp() {
        super.setUp()
        viewModelDouble = SummaryViewModelDouble()
        viewModelDouble.summaryTitleStub = "test title"
        viewModelDouble.summaryPriceStub = "test price"
        sut = SummaryViewController(viewModel: viewModelDouble)
        summaryView = sut.view as! SummaryView
    }

    override func tearDown() {
        viewModelDouble = nil
        sut = nil
        super.tearDown()
    }

    func testTableViewSetDataSource() {
        XCTAssert(summaryView.tableView.dataSource === sut)
    }

    func testTableViewSetDelegate() {
        XCTAssert(summaryView.tableView.delegate === sut)
    }

    func testTableViewNumberOfRows() {
        viewModelDouble.currencyRatesStub = ["test 1", "test 2"]
        viewModelDouble.reloadSpy!()
        XCTAssert(summaryView.tableView.numberOfRows(inSection: 0) == 2)
    }

    func testTableViewFirstCell() {
        viewModelDouble.currencyRatesStub = ["test 1"]
        viewModelDouble.reloadSpy!()
        let cell = summaryView.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssert(cell?.textLabel?.text == "test 1")
    }

    func testTableViewTapThirdCell() {
        viewModelDouble.currencyRatesStub = ["test 1", "test 2", "test 3"]
        viewModelDouble.reloadSpy!()
        sut.tableView(summaryView.tableView, didSelectRowAt: IndexPath(row: 2, section: 0))
        XCTAssert(viewModelDouble.rowSelected == 2)
    }

    func testTitle() {
        XCTAssert(sut.navigationItem.title == "test title")
    }

    func testSummaryPrice() {
        XCTAssert(summaryView.summaryLabel.text == "test price")
    }

    func testSummaryPriceUpdate() {
        viewModelDouble.updateSummaryPrice!("new test price")
        XCTAssert(summaryView.summaryLabel.text == "new test price")
    }

    func testCancelTap() {
        var cancelCalled = false
        sut.cancel = { cancelCalled = true }
        _ = sut.navigationItem.leftBarButtonItem!.target!.perform(sut.navigationItem.leftBarButtonItem!.action,
                                                                   with: nil)
        XCTAssert(cancelCalled)
    }
}
