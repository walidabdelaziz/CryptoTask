//
//  CryptoTVCell.swift
//  CryptoCoins
//
//  Created by Walid Ahmed on 16/01/2023.
//

import UIKit

class CryptoTVCell: UITableViewCell {
    
    var changePerHourLbl = UILabel()
    var rateLbl = UILabel()
    var nameLbl = UILabel()
    var stackView: UIStackView!
    var seperator = UIImageView()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Create the stack view
        let heightConstraint = NSLayoutConstraint(item: seperator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        seperator.addConstraint(heightConstraint)
        seperator.backgroundColor = .gray
        
        stackView = UIStackView(arrangedSubviews: [nameLbl, rateLbl, changePerHourLbl,seperator])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        contentView.addSubview(stackView)
        
        // Add constraints to the stack view and seperator
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var cryptoCurrency: CryptoCurrency? {
        didSet {
            guard let cryptoCurrency = cryptoCurrency else { return }
            self.nameLbl.text = "Name: \(cryptoCurrency.name ?? "")"
            self.rateLbl.text = "Price: \(String(format: "%.6f", cryptoCurrency.quote?.usd?.price ?? 0))"
            self.changePerHourLbl.text = "Change per hour: \(String(format: "%.2f", cryptoCurrency.quote?.usd?.percent_change_1h ?? 0))%"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
