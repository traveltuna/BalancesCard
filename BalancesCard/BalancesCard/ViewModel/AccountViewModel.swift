//
//  AccountViewModel.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/22.
//

import Foundation

struct AccountViewModel {
    var totalAmount = 0.0
    var institutions = [Institution]()
    
    func loadAccountsJson(completionHandler: @escaping (AccountViewModel?, String?) -> Void) {
        guard let url = Bundle.main.url(forResource: "accounts", withExtension: "json") else {
            completionHandler(nil, "Missing file: accounts.json")
            return
        }
        do {
            let json = try Data(contentsOf: url)
            let response = try? JSONDecoder().decode(AccountResponse.self, from: json)
            guard let accounts = response?.accounts else {
                completionHandler(nil, "Failed to decode accounts.json")
                return
            }
            var totalAmount = 0.0
            var dict = [String: [Account]]()
            for account in accounts {
                totalAmount += account.currentBalanceInBase
                dict[account.institution] = dict[account.institution, default: []] + [account]
            }
            var institutions = [Institution]()
            for key in dict.keys.sorted() {
                let institution = Institution(name: key,
                                              accounts: dict[key]!.sorted(by: { $0.nickname < $1.nickname }))
                institutions.append(institution)
            }
            completionHandler(AccountViewModel(totalAmount: totalAmount, institutions: institutions), nil)
        } catch {
            print("error: \(error)")
        }
    }
}

struct Institution {
    let name: String
    let accounts: [Account]
}
