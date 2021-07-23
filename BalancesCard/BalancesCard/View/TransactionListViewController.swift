//
//  TransactionListViewController.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/22.
//

import UIKit

final class TransactionListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    private var account: Account!
    
    static func instance(with account: Account) -> TransactionListViewController {
        let storyboard = UIStoryboard(name: "TransactionList", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! TransactionListViewController
        vc.account = account
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        registerCells()
    }
}

// MARK: Private Methods
private extension TransactionListViewController {
    func setupLabel() {
        nameLabel.text = account.nickname
        amountLabel.text = "JPY" + CurrencyFormatter.shared.format(with: account.currentBalanceInBase)
    }
    
    func registerCells() {
        
    }
}


// MARK: UITableViewDataSource Methods
extension TransactionListViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return accountViewModel.institutions.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return accountViewModel.institutions[section].accounts.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: AccountListTableViewCell.identifier,
//                                                 for: indexPath) as! AccountListTableViewCell
//        cell.configure(with: accountViewModel.institutions[indexPath.section].accounts[indexPath.row])
//        return cell
//    }
}

// MARK: UITableViewDelegate Methods
extension TransactionListViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AccountSectionHeaderView.identifier) as! AccountSectionHeaderView
//        header.configure(with: accountViewModel.institutions[section].name)
//        return header
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let account = accountViewModel.institutions[indexPath.section].accounts[indexPath.row]
//        let vc = TransactionListViewController.instance(with: account)
//        navigationController?.pushViewController(vc, animated: true)
//    }
}
