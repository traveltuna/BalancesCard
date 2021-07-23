//
//  Date + Format.swift
//  BalancesCard
//
//  Created by Fangwei Hsu on 2021/07/23.
//

import Foundation

extension Date {
    static let monthDict = [1: "January", 2: "February", 3: "March", 4: "April", 5: "May", 6: "June",
                            7: "July", 8: "August", 9: "September", 10: "October", 11: "November", 12: "December"]
    func monthYearStr() -> String {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        guard let month = components.month, let year = components.year, let monthStr = Date.monthDict[month] else {
            return ""
        }
        return monthStr + "\(year)"
    }
    
    func getYear() -> Int {
        let components = Calendar.current.dateComponents([.year], from: self)
        return components.year ?? 0
    }
    
    func getMonth() -> Int {
        let components = Calendar.current.dateComponents([.month], from: self)
        return components.month ?? 0
    }
}
