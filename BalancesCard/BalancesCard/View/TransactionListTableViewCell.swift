//
//  TransactionListTableViewCell.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/23.
//

import UIKit

final class TransactionListTableViewCell: UITableViewCell {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    
    func configure(with currency: String, transaction: Transaction) {
        dateLabel.text = "\(transaction.date.getDay())"
        descriptionLabel.text = transaction.description
        if transaction.amount >= 0 {
            amountLabel.text = currency + CurrencyFormatter.shared.format(with: transaction.amount)
        } else {
            amountLabel.text = "-" + currency + CurrencyFormatter.shared.format(with: -transaction.amount)
        }
    }
}
