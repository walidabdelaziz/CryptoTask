//
//  CryptoCoinsTests.swift
//  CryptoCoinsTests
//
//  Created by Walid Ahmed on 16/01/2023.
//

import XCTest
@testable import CryptoCoins

final class CryptoCoinsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testFetchData() {
        // Arrange
        let mockData = """
        {
            "coins": [
                {
                "id": 1,
                "name": "Bitcoin",
                "symbol": "BTC",
                "slug": "bitcoin",
                "quote": {
                "USD": {
                "price": 9283.92,
                "percent_change_1h": -0.152774,
                }
        }

            ]
        }
        """.data(using: .utf8)
        let mockURL = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"
        let mockHeaders = ["X-CMC_PRO_API_KEY": "f6cf9a86-2073-4cbf-8433-3a0d0a348727"]
        let networkManager = NetworkManager()
        let promise = expectation(description: "fetchData")
        
        // Act
        networkManager.fetchData(from: mockURL,start: 1,limit: 10, headers: mockHeaders) { (data, error) in
            // Assert
            XCTAssertNil(error)
            XCTAssertEqual(data, mockData)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5.0)
    }

}
