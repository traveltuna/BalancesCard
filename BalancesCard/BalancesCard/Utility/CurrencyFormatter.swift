//
//  CurrencyFormatter.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/23.
//

import Foundation

final class CurrencyFormatter {
    static let shared = CurrencyFormatter()
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func format(with amount: Double) -> String {
        guard let str = formatter.string(from: NSNumber(value: amount)) else {
            print("Failed to convert amount in currency format")
            return ""
        }
        return str
    }
}
