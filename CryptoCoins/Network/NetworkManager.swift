//
//  NetworkLayer.swift
//  CryptoCoins
//
//  Created by Walid Ahmed on 16/01/2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
     init() {}
    
    func fetchData(from urlString: String,start: Int, limit: Int, headers: [String: String], completion: @escaping (Data?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryParam1 = URLQueryItem(name: "start", value: "\(start)")
        let queryParam2 = URLQueryItem(name: "limit", value: "\(limit)")
        urlComponents.queryItems = [queryParam1, queryParam2]
        var request = URLRequest(url: urlComponents.url!)
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            }
            if let data = data {
                completion(data, nil)
            }
        }.resume()
    }
}

