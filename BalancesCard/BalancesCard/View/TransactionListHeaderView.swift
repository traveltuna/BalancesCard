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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        instantiateView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateView()
    }
    
    func configure(with account: Account) {
        nameLabel.text = account.nickname
        currentAmountLabel.text = account.currency + CurrencyFormatter.shared.format(with: account.currentBalance)
        if account.currency != "JPY" {
            currentAmountInBaseLabel.isHidden = false
            currentAmountInBaseLabel.text = "JPY" + CurrencyFormatter.shared.format(with: account.currentBalanceInBase)
        } else {
            currentAmountInBaseLabel.isHidden = true
        }
    }
}

private extension TransactionListHeaderView {
    func instantiateView() {
        let nib = UINib(nibName: TransactionListHeaderView.className, bundle: .main)
        let rootView = nib.instantiate(withOwner: self).first as! UIView
        rootView.frame = self.bounds
        self.addSubview(rootView)
    }
}
