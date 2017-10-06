//
//  SummaryView.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 05/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

class SummaryView: UIView {

    init() {
        super.init(frame: .zero)
        configureSubviews()
        addSubviews()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let tableView = Factory.tableView()
    let summaryLabel = Factory.summaryLabel()

    // MARK: - Privates

    private func configureSubviews() {
        backgroundColor = .white
    }

    private func addSubviews() {
        addSubview(tableView)
        addSubview(summaryLabel)
    }

    private func setupLayout() {
        let margins = layoutMarginsGuide

        tableView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true

        summaryLabel.topAnchor.constraint(lessThanOrEqualTo: tableView.layoutMarginsGuide.bottomAnchor).isActive = true
        summaryLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        summaryLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -30.0).isActive = true
    }
    
}

private extension SummaryView {

    struct Factory {

        static func tableView() -> UITableView {
            let tableView = UITableView()
            tableView.tableFooterView = UIView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }

        static func summaryLabel() -> UILabel {
            let label = UILabel()
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }

    }

}
