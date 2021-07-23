//
//  TransactionSectionHeaderView.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/23.
//

import UIKit

final class TransactionSectionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var totalInAmountLabel: UILabel!
    @IBOutlet private weak var totalOutAmountLabel: UILabel! {
        didSet {
            
        }
    }
    @IBOutlet private weak var totalInAmountView: UIView!
    @IBOutlet private weak var totalOutAmountView: UIView!
    
    func configure(with currency: String, monthlyTransaction: MonthTransaction) {
        dateLabel.text = monthlyTransaction.date
        if monthlyTransaction.totalIn == 0 {
            totalInAmountView.isHidden = true
        } else {
            totalInAmountView.isHidden = false
            totalInAmountLabel.text = currency + CurrencyFormatter.shared.format(with: monthlyTransaction.totalIn)
        }
        if monthlyTransaction.totalOut == 0 {
            totalOutAmountView.isHidden = true
        } else {
            totalOutAmountView.isHidden = false
            totalOutAmountLabel.text = "-" + currency + CurrencyFormatter.shared.format(with: -monthlyTransaction.totalOut)
        }
    }
}
