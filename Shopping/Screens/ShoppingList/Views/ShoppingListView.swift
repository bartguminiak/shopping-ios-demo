//
//  ShoppingListView.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 04/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

class ShoppingListView: UIView {

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
    let checkoutButton = Factory.checkoutButton()

    // MARK: - Privates

    private func configureSubviews() {
        backgroundColor = .white
    }

    private func addSubviews() {
        addSubview(tableView)
        addSubview(checkoutButton)
    }

    private func setupLayout() {
        let margins = layoutMarginsGuide

        tableView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        checkoutButton.topAnchor.constraint(lessThanOrEqualTo: tableView.layoutMarginsGuide.bottomAnchor).isActive = true
        checkoutButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        checkoutButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -30.0).isActive = true
    }

}

private extension ShoppingListView {

    struct Factory {

        static func tableView() -> UITableView {
            let tableView = UITableView()
            tableView.tableFooterView = UIView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }

        static func checkoutButton() -> UIButton {
            let button = UIButton(type: .custom)
            button.setTitle("Checkout", for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }

    }

}
