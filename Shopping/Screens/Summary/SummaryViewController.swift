//
//  SummaryViewController.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

protocol SummaryViewControllerDismission: class {
    var cancel: (() -> Void)? { get set }
}

protocol SummaryViewControllerInputs: class {
    var summaryTitle: String { get }
    var summaryPrice: String { get }
    var updateSummaryPrice: ((String) -> Void)? { get set }
    var currencyRates: [String] { get }
    var reload: (() -> Void)? { get set }
}

protocol SummaryViewControllerOutputs {
    func select(row: Int)
}

class SummaryViewController: UIViewController, SummaryViewControllerDismission, UITableViewDataSource, UITableViewDelegate {

    init(viewModel: SummaryViewControllerInputs & SummaryViewControllerOutputs) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = SummaryView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCancel()
        configureTitle()
        configureTableView()
        configureSummaryLabel()
    }

    // MARK: - SummaryViewControllerDismission

    var cancel: (() -> Void)?

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyRates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellId, for: indexPath)
        cell.textLabel?.text = viewModel.currencyRates[indexPath.row]
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(row: indexPath.row)
    }

    // MARK: - privates

    private let viewModel: SummaryViewControllerInputs & SummaryViewControllerOutputs

    private let reuseCellId = "itemCellId"
    
    private var summaryView: SummaryView! {
        return view as? SummaryView
    }

    private func configureCancel() {
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        cancelItem.addAction { [weak self] in
            self?.cancel?()
        }
        navigationItem.leftBarButtonItem = cancelItem
    }

    private func configureTitle() {
        navigationItem.title = viewModel.summaryTitle
    }

    private func configureTableView() {
        summaryView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseCellId)
        summaryView.tableView.dataSource = self
        summaryView.tableView.delegate = self
        viewModel.reload = { [weak self] in self?.summaryView.tableView.reloadData() }
    }

    private func configureSummaryLabel() {
        summaryView.summaryLabel.text = viewModel.summaryPrice
        viewModel.updateSummaryPrice = { [weak self] text in self?.summaryView.summaryLabel.text = text }
    }

}
