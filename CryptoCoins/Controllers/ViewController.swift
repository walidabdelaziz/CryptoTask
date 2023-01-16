//
//  ViewController.swift
//  CryptoCoins
//
//  Created by Walid Ahmed on 16/01/2023.
//

import UIKit

class ViewController: UIViewController {

    var cryptoCurrencies = [CryptoCurrency]()
    var refreshControlBooking = UIRefreshControl()
    var currentPage = 1
    var isLoadingList = false
    var coinsTV = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        getCryptoCurrencies(page: currentPage)
    }
    func setupUI(){
        title = "Crypto Currencies"
        coinsTV = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 32))
        coinsTV.delegate = self
        coinsTV.dataSource = self
        coinsTV.separatorStyle = .none
        view.addSubview(coinsTV)
        coinsTV.register(CryptoTVCell.self, forCellReuseIdentifier: "CryptoTVCell")
        coinsTV.estimatedRowHeight = UITableView.automaticDimension
        
        refreshControlBooking.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
        coinsTV.addSubview(refreshControlBooking)
    }
    @objc func refreshData(_ sender: AnyObject) {
        currentPage = 1
        getCryptoCurrencies(page: currentPage)
        self.refreshControlBooking.endRefreshing()
    }
    func loadMoreItems(){
        isLoadingList = true
        currentPage += 10
        getCryptoCurrencies(page: currentPage)
        
    }
    func getCryptoCurrencies(page: Int){
        let headers = ["X-CMC_PRO_API_KEY": "f6cf9a86-2073-4cbf-8433-3a0d0a348727"]
        NetworkManager.shared.fetchData(from: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest",start: page,limit: 10, headers: headers) { (data, error) in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(CoinMarketCapResponse.self, from: data)
                    if self.currentPage == 1 {
                        self.cryptoCurrencies.removeAll()
                    }
                    self.cryptoCurrencies += response.data
                    if response.data.isEmpty{
                        self.isLoadingList = true

                    }else{
                        self.isLoadingList = false

                    }
                    DispatchQueue.main.async {
                        self.coinsTV.reloadData()
                    }
                } catch let error {
                    print(error)
                }
            }
        }
    }


}
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row >= cryptoCurrencies.count - 2
            && !isLoadingList{
            loadMoreItems()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoTVCell", for: indexPath) as! CryptoTVCell
        cell.selectionStyle = .none
        let cryptoCurrency = cryptoCurrencies[indexPath.row]
        cell.cryptoCurrency = cryptoCurrency
        return cell
    }
    
    
}
