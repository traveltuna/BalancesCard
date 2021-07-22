//
//  Account.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/22.
//

import Foundation

struct AccountResponse: Codable {
    let accounts: [Account]
}

struct Account: Codable {
    let id: Int
    let nickname: String
    let institution: String
    let currency: String
    let currentBalance: Double
    let currentBalanceInBase: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nickname = "nickname"
        case institution = "institution"
        case currency = "currency"
        case currentBalance = "current_balance"
        case currentBalanceInBase = "current_balance_in_base"
    }
}
