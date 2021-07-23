//
//  AccountListTableViewCell.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/22.
//

import UIKit

final class AccountListTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    
    func configure(with account: Account) {
        nameLabel.text = account.nickname
        amountLabel.text = account.currency + CurrencyFormatter.shared.format(with: account.currentBalance)
    }
}
