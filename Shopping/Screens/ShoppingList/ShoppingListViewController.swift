//
//  ViewController.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 03/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

protocol ShoppingListViewControllerAssembly {
    var presenter: ViewControllerPresenting { get }
    var itemViewModelCreator: ItemViewModelCreating { get }
}

protocol ShoppingListViewControllerInputs: class {
    var itemTypes: [ItemType] { get }
    func itemCount(of type: ItemType) -> Int
    var viewControllerPresentation: ((UIViewController) -> Void)? { get set }
    var viewControllerDismission: ((UIViewController) -> Void)? { get set }
    var reload: (() -> Void)? { get set }
}

protocol ShoppingListViewControllerOutputs: class {
    func add(_ type: ItemType)
    func remove(_ type: ItemType)
    func checkout()
}

class ShoppingListViewController: UIViewController, UITableViewDataSource, ItemCellDelegate {

    init(assembly: ShoppingListViewControllerAssembly,
         viewModel: ShoppingListViewControllerInputs & ShoppingListViewControllerOutputs) {
        self.presenter = assembly.presenter
        self.itemViewModelCreator = assembly.itemViewModelCreator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ShoppingListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureCheckoutButton()
        configureViewControllerPresentation()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellId, for: indexPath) as? ItemCell else {
            fatalError("Cell must be ItemCell type!")
        }
        let type = viewModel.itemTypes[indexPath.row]
        let itemCount = viewModel.itemCount(of: type)

        let itemViewModel = itemViewModelCreator.create(with: type, count: itemCount)
        cell.configure(viewModel: itemViewModel, updateListeiner: self)

        return cell
    }

    // MARK: - ItemCellDelegate

    func counterViewDidIncrease(inCell cell: ItemCell) {
        guard let cellIndexPath = shoppingListView.tableView.indexPath(for: cell) else { return }
        let type = viewModel.itemTypes[cellIndexPath.row]
        viewModel.add(type)
    }

    func counterViewDidDecrease(inCell cell: ItemCell) {
        guard let cellIndexPath = shoppingListView.tableView.indexPath(for: cell) else { return }
        let type = viewModel.itemTypes[cellIndexPath.row]
        viewModel.remove(type)
    }

    // MARK: - Privates

    private let presenter: ViewControllerPresenting
    private let itemViewModelCreator: ItemViewModelCreating

    private let viewModel: ShoppingListViewControllerInputs & ShoppingListViewControllerOutputs

    private let reuseCellId = "itemCellId"

    private var shoppingListView: ShoppingListView! {
        return view as! ShoppingListView
    }

    private func configureTableView() {
        shoppingListView.tableView.dataSource = self
        shoppingListView.tableView.register(ItemCell.self, forCellReuseIdentifier: reuseCellId)

        viewModel.reload = { [weak self] in self?.shoppingListView.tableView.reloadData() }
    }

    private func configureCheckoutButton() {
        shoppingListView.checkoutButton.addTarget(self, action: #selector(checkoutAction), for: .touchUpInside)
    }

    private func configureViewControllerPresentation() {
        viewModel.viewControllerPresentation = { [weak self] viewController in
            guard let `self` = self else { return }
            self.presenter.present(viewController: viewController, on: self)
        }

        viewModel.viewControllerDismission = { [weak self] viewController in
            self?.presenter.dismiss(viewController: viewController)
        }
    }

    // MARK: - Checkout action

    @objc func checkoutAction() {
        viewModel.checkout()
    }

}

