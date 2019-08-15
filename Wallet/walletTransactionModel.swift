//
//  walletTransactionModel.swift
//  Wallet
//
//  Created by russell on 16/8/19.
//  Copyright © 2019 Cole. All rights reserved.
//

import Foundation
import SwiftyJSON

class WalletTransactionModel {
    var slug: String
    var name: String
    var amount: Double
    
    required init(slug: String, name: String, amount: Double) {
        self.slug = slug
        self.name = name
        self.amount = amount
    }
    
    convenience init?(item: JSON) {
        guard let slug = item["slug"].string,
               let name = item["name"].string,
            let amount = item["amount"].double else { return nil}
        
        self.init(slug: slug, name: name, amount: amount)
    }
    
}
