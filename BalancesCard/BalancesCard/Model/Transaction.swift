//
//  Transaction.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/22.
//

import Foundation

struct TransactionResponse: Codable {
    let transactions: [Transaction]
}

struct Transaction: Codable {
    let accountId: Int
    let amount: Double
    let categoryId: Int
    let date: String
    let description: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case amount = "amount"
        case categoryId = "category_id"
        case date = "date"
        case description = "description"
        case id = "id"
    }
}
