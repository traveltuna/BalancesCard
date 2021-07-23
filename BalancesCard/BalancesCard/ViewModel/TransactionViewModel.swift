//
//  TransactionViewModel.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/22.
//

import Foundation

struct TransactionViewModel {
    var monthlyTransactions = [MonthTransaction]()
    
    func loadTransactionJson(with accountId: Int, completionHandler: @escaping (TransactionViewModel?, String?) -> Void) {
        let fileName = "transactions_\(accountId)"
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            completionHandler(nil, "Missing file: \(fileName).json")
            return
        }
        do {
            let json = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let response = try? decoder.decode(TransactionResponse.self, from: json)
            guard let transactions = response?.transactions else {
                completionHandler(nil, "Failed to decode \(fileName).json")
                return
            }
            var dict = [[Int]: [Transaction]]()
            for transaction in transactions {
                let ar = [transaction.date.getYear(), transaction.date.getMonth()]
                dict[ar] = dict[ar, default: []] + [transaction]
            }
            let sortedKeys = dict.keys.sorted(by: { a, b in
                if a[0] > b[0] {
                    return true
                } else if a[0] < b[0] {
                    return false
                } else {
                    return a[1] > b[1]
                }
            })
            var ar = [MonthTransaction]()
            for key in sortedKeys {
                var totalIn = 0.0
                var totalOut = 0.0
                for transaction in dict[key]! {
                    if transaction.amount > 0 {
                        totalIn += transaction.amount
                    } else {
                        totalOut += transaction.amount
                    }
                }
                let monthYearStr = Date.monthDict[key[1]]! + " \(key[0])"
                let monthlyTransaction = MonthTransaction(date: monthYearStr,
                                                          totalIn: totalIn,
                                                          totalOut: totalOut,
                                                          transactions: dict[key]!.sorted(by: { $0.date > $1.date }))
                ar.append(monthlyTransaction)
            }
            completionHandler(TransactionViewModel(monthlyTransactions: ar), nil)
        } catch {
            print("error: \(error)")
        }
    }
}

struct MonthTransaction {
    let date: String
    let totalIn: Double
    let totalOut: Double
    let transactions: [Transaction]
}
