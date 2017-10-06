//
//  ItemCell.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 04/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

protocol ItemCellDelegate: class {
    func counterViewDidIncrease(inCell cell: ItemCell)
    func counterViewDidDecrease(inCell cell: ItemCell)
}

class ItemCell: UITableViewCell, CounterViewDelegate {

    func configure(viewModel: ItemViewModelPresentable, updateListeiner: ItemCellDelegate) {
        titleLabel.text = viewModel.displayTitle
        counterView.count = viewModel.count
        delegate = updateListeiner
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSelf()
        addSubviews()
        setupLayout()
        configureCounterView()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func prepareForReuse() {
        super.prepareForReuse()

        cleanUp()
    }

    // MARK: - CounterViewDelegate

    func counterViewDidIncrease(inView view: CounterView) {
        delegate?.counterViewDidIncrease(inCell: self)
    }

    func counterViewDidDecrease(inView view: CounterView) {
        delegate?.counterViewDidDecrease(inCell: self)
    }

    // MARK: - Privates

    private weak var delegate: ItemCellDelegate?

    private let titleLabel = Factory.titleLabel()
    private let counterView = Factory.counterView()

    private func configureSelf() {
        backgroundColor = .white
        selectionStyle = .none
        accessoryType = .none
    }

    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(counterView)
    }

    private func setupLayout() {
        let margins = contentView.layoutMarginsGuide

        titleLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16.0).isActive = true

        counterView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        counterView.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        counterView.widthAnchor.constraint(equalToConstant: 100.0)
        counterView.heightAnchor.constraint(equalToConstant: 40)
    }

    private func configureCounterView() {
        counterView.delegate = self
    }

    private func cleanUp() {
        titleLabel.text = nil
        delegate = nil
        counterView.count = 0
    }

}

private extension ItemCell {

    struct Factory {

        static func titleLabel() -> UILabel {
            let label = UILabel()
            label.textColor = .darkGray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }

        static func counterView() -> CounterView {
            let counterView = CounterView(initialCount: 0)
            counterView.translatesAutoresizingMaskIntoConstraints = false
            return counterView
        }

    }

}
