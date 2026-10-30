//
//  CounterView.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 04/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

protocol CounterViewDelegate: class {
    func counterView(did change: CounterView.Change, inView view: CounterView)
}

class CounterView: UIView {

    enum Change {
        case increase, decrease
    }

    weak var delegate: CounterViewDelegate?

    var count: Int { didSet { countLabel.text = "\(count)"}}

    init(initialCount: Int) {
        self.count = initialCount
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Privates

    private let minusButton = Factory.minusButton()
    private let countLabel = Factory.countLabel()
    private let plusButton = Factory.plusButton()

    private func addSubviews() {
        addSubview(minusButton)
        addSubview(countLabel)
        addSubview(plusButton)
    }

    private func setupLayout() {
        let margins = layoutMarginsGuide

        minusButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        minusButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        minusButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        countLabel.leadingAnchor.constraint(equalTo: minusButton.layoutMarginsGuide.trailingAnchor, constant: 12).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 2).isActive = true

        plusButton.leadingAnchor.constraint(equalTo: countLabel.layoutMarginsGuide.trailingAnchor, constant: 12).isActive = true
        plusButton.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }

    private func configureSubviews() {
        minusButton.addAction(for: .touchUpInside) { [weak self] in
            guard let `self` = self else { return }
            self.delegate?.counterView(did: .decrease, inView: self)
        }
        plusButton.addAction(for: .touchUpInside) { [weak self] in
            guard let `self` = self else { return }
            self.delegate?.counterView(did: .increase, inView: self)
        }
    }

}

private extension CounterView {

    struct Factory {

        static func minusButton() -> UIButton {
            return button("-")
        }

        static func countLabel() -> UILabel {
            let label = UILabel()
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 20)
            return label
        }

        static func plusButton() -> UIButton {
            return button("+")
        }

        private static func button(_ title: String) -> UIButton {
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
            return button
        }

    }

}
