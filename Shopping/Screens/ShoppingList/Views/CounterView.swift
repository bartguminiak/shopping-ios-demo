//
//  CounterView.swift
//  Shopping
//
//  Created by Bartlomiej Guminiak on 04/10/2017.
//  Copyright © 2017 Bartlomiej Guminiak. All rights reserved.
//

import UIKit

protocol CounterViewDelegate: class {
    func counterViewDidIncrease(inView view: CounterView)
    func counterViewDidDecrease(inView view: CounterView)
}

class CounterView: UIView {

    weak var delegate: CounterViewDelegate?

    var count: Int { didSet { updateCountLabel() }}

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
        minusButton.addTarget(self, action: #selector(minusAction), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusAction), for: .touchUpInside)
        updateCountLabel()
    }

    // MARK: Actions

    @objc func plusAction() {
        delegate?.counterViewDidIncrease(inView: self)
    }

    @objc func minusAction() {
        delegate?.counterViewDidDecrease(inView: self)
    }

    private func updateCountLabel() {
        countLabel.text = "\(count)"
    }

}

private extension CounterView {

    struct Factory {

        static func minusButton() -> UIButton {
            let button = UIButton(type: .custom)
            button.setTitle("-", for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
            return button
        }

        static func countLabel() -> UILabel {
            let label = UILabel()
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 20)
            return label
        }

        static func plusButton() -> UIButton {
            let button = UIButton(type: .custom)
            button.setTitle("+", for: .normal)
            button.setTitleColor(.red, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.titleLabel?.font = UIFont.systemFont(ofSize: 26)
            return button
        }

    }

}
