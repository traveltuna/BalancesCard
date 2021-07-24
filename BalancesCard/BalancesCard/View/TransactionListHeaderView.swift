//
//  TransactionListHeaderView.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/23.
//

import UIKit

final class TransactionListHeaderView: UIView {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var currentAmountLabel: UILabel!
    @IBOutlet private weak var currentAmountInBaseLabel: UILabel!
    @IBOutlet private weak var thisMonthTotalInAmountLabel: UILabel!
    @IBOutlet private weak var thisMonthTotalOutAmountLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantiateView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateView()
    }
    
    func configure(with account: Account, latestTransaction: MonthTransaction?) {
        nameLabel.text = account.nickname
        currentAmountLabel.text = account.currency + CurrencyFormatter.shared.format(with: account.currentBalance)
        if account.currency != "JPY" {
            currentAmountInBaseLabel.isHidden = false
            currentAmountInBaseLabel.text = "JPY" + CurrencyFormatter.shared.format(with: account.currentBalanceInBase)
        } else {
            currentAmountInBaseLabel.isHidden = true
        }
        guard let latestTransaction = latestTransaction, latestTransaction.date ==  Date.currentMonthYearStr() else {
            thisMonthTotalInAmountLabel.text = account.currency + "0"
            thisMonthTotalOutAmountLabel.text = account.currency + "0"
            return
        }
        thisMonthTotalInAmountLabel.text = account.currency + CurrencyFormatter.shared.format(with: latestTransaction.totalIn)
        thisMonthTotalOutAmountLabel.text = account.currency + CurrencyFormatter.shared.format(with: latestTransaction.totalOut)
    }
}

private extension TransactionListHeaderView {
    func instantiateView() {
        let nib = UINib(nibName: TransactionListHeaderView.className, bundle: .main)
        let rootView = nib.instantiate(withOwner: self).first as! UIView
        rootView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        rootView.frame = self.bounds
        self.addSubview(rootView)
    }
}
