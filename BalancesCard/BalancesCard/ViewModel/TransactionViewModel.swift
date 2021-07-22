//
//  TransactionViewModel.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/22.
//

import Foundation

struct TransactionViewModel {
    let currentBalance: Double
    let monthlyTransactions: [MonthTransaction]
}

struct MonthTransaction {
    let date: String
    let totalIn: Double
    let totalOut: Double
    let transactions: [Transaction]
}
