//
//  AccountSectionHeaderView.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/22.
//

import UIKit

final class AccountSectionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet private weak var titleLabel: UILabel!
    
    func configure(with name: String) {
        titleLabel.text = name
    }
}
