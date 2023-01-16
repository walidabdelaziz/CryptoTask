//
//  CryptoModel.swift
//  CryptoCoins
//
//  Created by Walid Ahmed on 16/01/2023.
//

import Foundation
struct CoinMarketCapResponse: Codable {
    let data: [CryptoCurrency]
}

struct CryptoCurrency: Codable {
    let id: Int?
    let name: String?
    let symbol: String?
    let quote: Quote?

}
struct Quote: Codable {
    let usd: USD?
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
    struct USD: Codable {
        let price,percent_change_1h: Double?
    }
}
