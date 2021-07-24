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
    @IBOutlet private weak var headerView: TransactionListHeaderView!
    private var account: Account!
    private var transactionViewModel = TransactionViewModel()
    
    static func instance(with account: Account) -> TransactionListViewController {
        let storyboard = UIStoryboard(name: "TransactionList", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! TransactionListViewController
        vc.account = account
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        transactionViewModel.loadTransactionJson(with: account.id) { [weak self] viewModel, errorStr in
            guard let self = self else {
                return
            }
            guard let vm = viewModel else {
                return
            }
            self.transactionViewModel = vm
            self.headerView.configure(with: self.account,
                                      latestTransaction: vm.monthlyTransactions.first)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: Private Methods
private extension TransactionListViewController {
    func registerCells() {
        tableView.register(UINib(nibName: TransactionListTableViewCell.className, bundle: nil),
                           forCellReuseIdentifier: TransactionListTableViewCell.identifier)
        tableView.register(UINib(nibName: TransactionSectionHeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: TransactionSectionHeaderView.identifier)
    }
}


// MARK: UITableViewDataSource Methods
extension TransactionListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return transactionViewModel.monthlyTransactions.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionViewModel.monthlyTransactions[section].transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionListTableViewCell.identifier,
                                                 for: indexPath) as! TransactionListTableViewCell
        cell.configure(with: account.currency,
                       transaction: transactionViewModel.monthlyTransactions[indexPath.section].transactions[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate Methods
extension TransactionListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TransactionSectionHeaderView.identifier) as! TransactionSectionHeaderView
        header.configure(with: account.currency,
                         monthlyTransaction: transactionViewModel.monthlyTransactions[section])
        return header
    }
}
