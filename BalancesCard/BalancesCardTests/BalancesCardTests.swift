//
//  BalancesCardTests.swift
//  BalancesCardTests
//
//  Created by Fangwei Hsu on 2021/07/22.
//

import XCTest
@testable import BalancesCard

class BalancesCardTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadAndParseAccountsJson() throws {
        guard let url = Bundle.main.url(forResource: "accounts", withExtension: "json") else {
            XCTFail("Missing file: accounts.json")
            return
        }
        let json = try Data(contentsOf: url)
        let response = try? JSONDecoder().decode(AccountResponse.self, from: json)
        guard let account = response?.accounts.first else {
            XCTFail("Failed to decode accounts.json")
            return
        }
        
        XCTAssertEqual(account.id, 1)
        XCTAssertEqual(account.nickname, "外貨普通(USD)")
        XCTAssertEqual(account.institution, "Test Bank")
        XCTAssertEqual(account.currency, "USD")
        XCTAssertEqual(account.currentBalance, 22.5)
        XCTAssertEqual(account.currentBalanceInBase, 2306.0)
    }
    
    func testLoadAndParseTransactionsJson() throws {
        guard let url = Bundle.main.url(forResource: "transactions_2", withExtension: "json") else {
            XCTFail("Missing file: transactions_2.json")
            return
        }
        let json = try Data(contentsOf: url)
        let response = try? JSONDecoder().decode(TransactionResponse.self, from: json)
        guard let transaction = response?.transactions[2] else {
            XCTFail("Failed to decode accounts.json")
            return
        }
        
        XCTAssertEqual(transaction.accountId, 2)
        XCTAssertEqual(transaction.amount, -421.0)
        XCTAssertEqual(transaction.categoryId, 112)
        XCTAssertEqual(transaction.date, "2017-05-23T00:00:00+09:00")
        XCTAssertEqual(transaction.description, "スターバックス 原宿店")
        XCTAssertEqual(transaction.id, 23)
    }
}
