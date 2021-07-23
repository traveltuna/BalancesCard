//
//  AccountListViewController.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/22.
//

import UIKit

final class AccountListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet private weak var amountLabel: UILabel!
    private var accountViewModel = AccountViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        accountViewModel.loadAccountsJson { [weak self] viewModel, errorStr in
            guard let vm = viewModel else {
                return
            }
            self?.accountViewModel = vm
            self?.amountLabel.text = "JPY" + CurrencyFormatter.shared.format(with: vm.totalAmount)
            self?.tableView.reloadData()
        }
    }
}

// MARK: Private Methods
private extension AccountListViewController {
    func registerCells() {
        tableView.register(UINib(nibName: AccountListTableViewCell.className, bundle: nil),
                           forCellReuseIdentifier: AccountListTableViewCell.identifier)
        tableView.register(UINib(nibName: AccountSectionHeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: AccountSectionHeaderView.identifier)
    }
}

// MARK: UITableViewDataSource Methods
extension AccountListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return accountViewModel.institutions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountViewModel.institutions[section].accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountListTableViewCell.identifier,
                                                 for: indexPath) as! AccountListTableViewCell
        cell.configure(with: accountViewModel.institutions[indexPath.section].accounts[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate Methods
extension AccountListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AccountSectionHeaderView.identifier) as! AccountSectionHeaderView
        header.configure(with: accountViewModel.institutions[section].name)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = accountViewModel.institutions[indexPath.section].accounts[indexPath.row]
        let vc = TransactionListViewController.instance(with: account)
        navigationController?.pushViewController(vc, animated: true)
    }
}
